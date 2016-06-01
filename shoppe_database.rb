require './data_parser'
require './transaction_parser'
require 'set'
require 'bigdecimal' # to avoid floating point precision issues with money

class ShoppeDatabase
	attr_accessor(
		:transaction_parser,
		:data_parser
	)

	def initialize(transaction_parser:, data_parser:)
		self.transaction_parser = transaction_parser
		self.data_parser = data_parser
	end

	# returns { user_id => user, ... }
	def indexed_users
		@indexed_users ||= Hash[data_parser.users.map { |x| [x.id, x] }]
	end

	# returns { item_id => item, ... }
	def indexed_items
		@indexed_items ||= Hash[data_parser.items.map { |x| [x.id, x] }]
	end

	def user_by_id(user_id)
		indexed_users[user_id.to_i]
	end

	def user_with_most_orders
		uid, tx_count = transactions.group_by(&:user_id).map {|uid, txs| [uid, txs.length] }.sort_by { |uid, num_txs| num_txs }.last

		user_by_id(uid)
	end

	# using keyword arguments.
	# This allows one to call items(category: 'Tools'), instead of items(nil, 'Tools')
	def items(name: nil, category: nil)
		data_parser.items.select do |x|
			(name.nil? || name == x.name) && (category.nil? || x.category == category)
		end
	end

	# double splat on item_query for a hash
	def item_transactions(**item_query)

		item_ids = Set.new(items(item_query).map(&:id))

		transactions.select { |tx| item_ids.include? tx.item_id }
	end

	# double splat on item_query for a hash
	def items_sold(**item_query)
		item_transactions(item_query).map(&:quantity).inject(:+)
	end

	def transactions
		@transactions ||= transaction_parser.data
	end

	def revenue_by_category
		totals_by_category = {}

		transactions.each do |tx|
			item = indexed_items[tx.item_id]
			totals_by_category[item.category] ||= 0
			#totals_by_category[item.category] += indexed_items[tx.item_id].price * tx.quantity # floating point accuracy :(
			totals_by_category[item.category] += BigDecimal.new(indexed_items[tx.item_id].price.to_s) * tx.quantity
		end

		totals_by_category
	end

	def highest_grossing_category
		cat, total = revenue_by_category.map {|cat, total| [cat, total.to_f] }.sort_by {|cat, total| total }.last
		cat
	end

	def revenue
		total = 0
		transactions.each do |tx|
			#total += indexed_items[tx.item_id].price * tx.quantity # floating point accuracy :(
			total += BigDecimal.new(indexed_items[tx.item_id].price.to_s) * tx.quantity
		end

		total.to_f # remove scientific notation on bigdecimal
	end



end
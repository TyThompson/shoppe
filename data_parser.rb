require 'json'
require './user'
require './item'


class DataParser
	attr_accessor(
		:path
	)


	def initialize(file_path)
		self.path = file_path
		@data = {
			'users' => [],
			'items' => []
		}
	end

	def parse!
		@data = JSON.parse File.read path
	end


	def users
		@data['users'].map do |data_user|
			# use * splat operator to get multiple arguments to User.new
			User.new(*data_user.values_at("id", "name", "address"))
		end
	end

	def items
		@data['items'].map do |data_item|
			# use * splat operator to get multiple arguments to Item.new
			Item.new(*data_item.values_at("id", "name", "price", "category"))
		end
	end


end
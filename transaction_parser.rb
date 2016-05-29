require 'json'
require 'pry'
require './transaction'

class TransactionParser

	attr_accessor(
		:file_path,
		:data
	)
	
	def initialize(file_path)
		self.file_path = file_path
		@data = []
	end

	def parse!
		# use * splat operator to get multiple arguments to Transaction.new
		@data = JSON.parse(File.read(file_path)).map {|tx| Transaction.new(*tx.values_at(*%w(timestamp user_id item_id quantity)))  }
	end

	def transaction_count
		data.count
	end

end
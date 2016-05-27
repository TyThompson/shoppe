require 'json'
require 'pry'
require './data_parser'

class TransactionParser
	def initialize(file_path)
		
	end

	def path
		"tests/"+"file_path"+".json"
	end

	def parse!
		JSON.parse File.read "path"
	end

	def transaction_count

	end

end
require 'json'
require 'pry'
require './transaction_parser'


class DataParser
	def initialize(file_path)
		JSON.parse File.read "path"
	end

	def path
		"tests/"+"file_path"+".json"
	end

	#needs to count users, items

end
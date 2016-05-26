require 'json'
require 'pry'
require './transactionparser'


class DataParser
	def initialize(file_path)
		JSON.parse File.read "path"
	end

	def path
		"tests/"+"file_path"+".json"
	end

	#needs to count users, items

end
binding.pry
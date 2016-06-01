require './data_parser'
require 'json'
class ApiDataParser < DataParser

	def initialize(password)
		@password = password
		@data = {
			'users' => [],
			'items' => []
		}
	end

	def fetch!
		resp = HTTParty.get("https://shopnatra.herokuapp.com/data", query: { password: @password })
		@data = JSON.parse(resp.body)
	end
end
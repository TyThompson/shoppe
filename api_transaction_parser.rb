require './transaction_parser'
require 'json'

class ApiTransactionParser < TransactionParser

	def initialize(password)
		@password = password
		@data = []
	end

	def fetch!(date)
		formatted_date = date.strftime('%Y-%m-%d')
		resp = HTTParty.get("https://shopnatra.herokuapp.com/transactions/#{formatted_date}", query: { password: @password })
		@data = JSON.parse(resp.body).map {|tx| Transaction.new(*tx.values_at(*%w(timestamp user_id item_id quantity)))  }
	end
end

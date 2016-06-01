require 'httparty'
require 'pry'
require './api_transaction_parser'
require './api_data_parser'
require './shoppe_database'
require './token'

puts "Which date would you like to check transactions? Format: YYYY-MM-DD"
date = Date.parse(gets.chomp)
# date = "2016-04-04"

password = @token
tp = ApiTransactionParser.new(password)
dp = ApiDataParser.new(password)

tp.fetch!(date)
dp.fetch!


sn = ShoppeDatabase.new(transaction_parser: tp, data_parser: dp)

puts "The user that made the most orders was #{sn.user_with_most_orders.name}"
puts "We sold #{sn.items_sold(name: "Ergonomic Rubber Lamp")} Ergonomic Rubber Lamps"
puts "We sold #{sn.items_sold(category: "Tools")} items from the Tools category"
puts "Our total revenue was $#{sn.revenue}"
puts "Harder: the highest grossing category was #{sn.highest_grossing_category}"
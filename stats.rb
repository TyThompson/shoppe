require './shoppe_database'
require './data_parser'
require './transaction_parser'
tp = TransactionParser.new('data/transactions.json')
dp = DataParser.new('data/data.json')

tp.parse!
dp.parse!

db = ShoppeDatabase.new(transaction_parser: tp, data_parser: dp)


puts "The user that made the most orders was #{db.user_with_most_orders.name}"
puts "We sold #{db.items_sold(name: "Ergonomic Rubber Lamp")} Ergonomic Rubber Lamps"
puts "We sold #{db.items_sold(category: "Tools")} items from the Tools category"
puts "Our total revenue was $#{db.revenue}"
puts "Harder: the highest grossing category was #{db.highest_grossing_category}"
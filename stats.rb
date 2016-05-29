require './shoppe_database'

db = ShoppeDatabase.new(transaction_file_path: 'data/transactions.json', data_file_path: 'data/data.json')


puts "The user that made the most orders was #{db.user_with_most_orders.name}"
puts "We sold #{db.items_sold(name: "Ergonomic Rubber Lamp")} Ergonomic Rubber Lamps"
puts "We sold #{db.items_sold(category: "Tools")} items from the Tools category"
puts "Our total revenue was $#{db.revenue}"
puts "Harder: the highest grossing category was #{db.highest_grossing_category}"

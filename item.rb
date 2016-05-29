class Item

	attr_accessor(
		:id,
		:name,
		:price,
		:category
	)

	def initialize(id, name, price, category = nil)
		self.id = id
		self.name = name
		self.price = price
		self.category = category
	end
end
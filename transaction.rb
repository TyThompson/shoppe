# wanted to use map(&:property) instead of map { |tx| tx['property'] } for collecting values
# in shoppe database so creating a struct.
Transaction = Struct.new(:timestamp, :user_id, :item_id, :quantity)

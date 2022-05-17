require 'pg'

class Space
  attr_reader :id, :name, :description, :price

  def initialize(id:, name:, description:, price:)
    @id = id
    @name = name
    @description = description
    @price = price

  end

  def self.all
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'chuckle_hotel_test')
    else
      connection = PG.connect(dbname: 'chuckle_hotel')
    end
    
    result = connection.exec("SELECT * FROM spaces;")
    result.map do |space|
      Space.new(id: space['id'], name: space['name'], description: space['description'], price: space['price'])
    end 
  end

  def self.create(name:, description:, price:)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'chuckle_hotel_test')
    else
      connection = PG.connect(dbname: 'chuckle_hotel')
    end
     
    result = connection.exec_params("INSERT INTO spaces (name, description, price)
      VALUES($1, $2, $3) returning id, name, description, price;",
      [name, description, price])

    Space.new(
      id: result[0]['id'],
      name: result[0]['name'],
      description: result[0]['description'],
      price: result[0]['price']
    )
  end

  def self.find(id:)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'chuckle_hotel_test')
    else
      connection = PG.connect(dbname: 'chuckle_hotel')
    end

    result = connection.exec_params("SELECT * FROM spaces WHERE id = $1;",
    [id])
    
    Space.new(
      id: result[0]['id'],
      name: result[0]['name'],
      description: result[0]['description'],
      price: result[0]['price']
    )
  end 
end
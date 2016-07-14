class City
  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @id= attributes[:id] || nil
    @name = attributes.fetch(:name)
  end

  define_singleton_method(:all) do
    all_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    all_cities.each() do |city|
      name = city.fetch("name")
      id = city.fetch("id").to_i()
      cities.push(City.new({:id => id, :name => name}))
    end
    cities
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |other_city|
    self.id() == other_city.id()
  end

  define_singleton_method(:find) do |id|
    City.all().each() do |city|
      if city.id() == id
        return city
      end
    end
  end

  define_method(:update) do |attributes|
    @id = self.id()
    @name = attributes.fetch(:name)
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM cities WHERE id = #{self.id()};")
  end

  define_method(:trains) do
    results = DB.exec("SELECT id,train_id,time FROM cities_trains WHERE city_id = #{self.id()};")
     city_trains = []

    results.each() do |result|
      train_id = result.fetch("train_id").to_i()
      time = result.fetch("time")
      id = result.fetch("id").to_i()
      city_trains.push(Schedule.new({:id => id, :train_id => train_id, :city_id => self.id() ,:time => time}))
    end
    city_trains
  end
end

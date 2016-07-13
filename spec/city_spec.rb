require('spec_helper')

describe('city') do

  describe('#initialize') do
    it('creates a new city') do
      test_city = City.new({:name => 'Portland'})

      expect(test_city.name()).to(eq('Portland'))
    end
  end

  describe('save') do
    it("creates a new city and saves the city")do
      test_city = City.new({:name => 'Portland'})
      test_city.save()

      expect(City.all()).to(eq([test_city]))
    end
  end

  describe('#==') do
    it("returns true when two cities have the same ID") do
      test_city = City.new({:name => 'Portland'})
      test_city.save()
      test_city1 = City.new({:name => 'Seatle'})
      test_city1.save()

      expect(test_city1.==test_city1).to(eq(true))
    end
  end

  describe('.find') do
    it('returns the train by ID') do
      test_city = City.new({:name => 'Portland'})
      test_city.save()
      test_city1 = City.new({:name => 'Seatle'})
      test_city1.save()

      expect(City.find(test_city1.id())).to(eq(test_city1))
    end
  end

  describe('#update') do
    it('find a peticular city and changes its name') do
      test_city = City.new({:name => 'Portland'})
      test_city.save()
      test_city.update({:name => "Seattle"})
      
      expect(test_city.name()).to(eq("Seattle"))
    end
  end

  describe('#delete') do
    it('find a peticular city and changes its name') do
      test_city = City.new({:name => 'Portland'})
      test_city.save()
      test_city.delete()

      expect(City.all()).to(eq([]))
    end
  end
end

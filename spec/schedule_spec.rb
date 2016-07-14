require('spec_helper')

describe('schedule') do
  describe('#initialize') do
    it('creates a new schedule') do
      test_schedule = Schedule.new({:train_id => 3, :city_id => 2, :time => "12:30"})
      expect(test_schedule.time()).to(eq("12:30"))
    end
  end

  describe('#save') do
    it "creates a new schedule and saves it" do
      test_schedule = Schedule.new({:train_id => 3, :city_id => 2, :time => '12:30:00'})
      test_schedule.save()

      expect(Schedule.all()).to(eq([test_schedule]))
    end
  end

  describe('#==') do
    it('returns true if two schedules are the same') do
      test_schedule = Schedule.new({:train_id => 3, :city_id => 2, :time => '12:30:00'})
      test_schedule2 = Schedule.new({:train_id => 3, :city_id => 2, :time => '12:45:00'})
      test_schedule.save()
      test_schedule2.save()

      expect(test_schedule2.==test_schedule2).to(eq(true))
      end
  end

  describe('.find') do
    it "returns a peticular schedule by ID" do
      test_schedule = Schedule.new({:train_id => 3, :city_id => 2, :time => '12:30:00'})
      test_schedule2 = Schedule.new({:train_id => 3, :city_id => 2, :time => '12:45:00'})
      test_schedule.save()
      test_schedule2.save()

      expect(Schedule.find(test_schedule2.id())).to(eq(test_schedule2))
    end
  end

  describe('#delete') do
    it("find a peticular schedule and delete it") do
      test_schedule = Schedule.new({:train_id => 3, :city_id => 2, :time => '12:30:00'})
      test_schedule.save()
      test_schedule.delete()

      expect(Schedule.all()).to(eq([]))
    end
  end

  describe('update') do
    it("find a peticular schedule and change its values") do
      test_schedule = Schedule.new({:train_id => 3, :city_id => 2, :time => '12:30:00'})
      test_schedule.save()
      test_schedule.update({:train_id => 1, :city_id => 5, :time => '11:30:00'})

      expect(test_schedule.train_id()).to(eq(3))
    end
  end
end

describe('#train_name') do
  it("finds a peticular train name from the trains database") do
    test_train = Train.new({:name => 'Green Line'})
    test_train.save()
    test_city = City.new({:name => 'Portland'})
    test_city.save()
    test_schedule = Schedule.new({:train_id => test_train.id(), :city_id => test_city.id(), :time => '12:30:00'})
    test_schedule.save()
    name = test_schedule.city_name()

    expect(name).to(eq("Portland"))
  end
end

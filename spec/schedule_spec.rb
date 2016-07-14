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
binding.pry
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


end

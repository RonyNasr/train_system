class Schedule
  attr_reader(:train_id, :city_id, :id, :time)

  define_method(:initialize) do |attributes|
    @id = attributes[:id] || nil
    @train_id = attributes.fetch(:train_id)
    @city_id = attributes.fetch(:city_id)
    @time = attributes.fetch(:time)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO cities_trains (train_id, city_id, time) VALUES (#{@train_id}, #{@city_id}, '#{@time}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:==) do |other_schedule|
    self.id() == other_schedule.id()
  end

  define_singleton_method(:find) do |id|
    Schedule.all().each() do |schedule|
      if schedule.id() == id
        return schedule
      end
    end
  end

  define_singleton_method(:all) do
    all_schedules = DB.exec("SELECT * FROM cities_trains;")
    schedules = []
    all_schedules.each() do |schedule|
      train_id = schedule.fetch('train_id').to_i()
      city_id = schedule.fetch('city_id').to_i()
      time = schedule.fetch('time')
      id = schedule.fetch('id').to_i()
      schedules.push(Schedule.new({:id => id, :train_id => train_id, :city_id => city_id, :time => time}))
    end
    schedules
  end



end

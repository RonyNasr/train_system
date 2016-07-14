require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/train')
require('./lib/city')
require('pg')

DB = PG.connect({:dbname => "train_system"})

get('/') do
  erb(:index)
end

get('/operator') do
  erb(:operator)
end

get("/operator/trains") do
  @trains = Train.all()
  erb(:trains)
end

get("/operator/cities") do
  @cities = City.all()
  erb(:cities)
end

get('/train_form') do
  erb(:train_form)
end

post('/operator/trains') do
  name = params.fetch('name')
  Train.new({:name => name}).save()
  @trains = Train.all()
  erb(:trains)
end


get('/city_form') do
  erb(:city_form)
end

post('/operator/cities') do
  name = params.fetch('name')
  City.new({:name => name}).save()
  @cities = City.all()
  erb(:cities)
end

get('/operator/trains/:id') do
  id = params.fetch("id").to_i()
  @train = Train.find(id)
  erb(:train)
end

patch('/operator/trains/:id') do
  name = params.fetch('name')
  @train = Train.find(params.fetch('id').to_i())
  @train.update({:name => name})
  @trains = Train.all()
  erb(:trains)
end

delete('/operator/trains/:id') do
  @train = Train.find(params.fetch('id').to_i())
  @train.delete()
  @trains = Train.all()
  erb(:trains)
end

get('/operator/cities/:id') do
  id = params.fetch("id").to_i()
  @city = City.find(id)
  erb(:city)
end

patch('/operator/cities/:id') do
  name = params.fetch('name')
  @city = City.find(params.fetch('id').to_i())
  @city.update({:name => name})
  @cities = City.all()
  erb(:cities)
end

delete('/operator/cities/:id') do
  @city = City.find(params.fetch('id').to_i())
  @city.delete()
  @cities = City.all()
  erb(:cities)
end

get('/rider') do
  erb(:rider)
end

get("/rider/trains") do
  @trains = Train.all()
  erb(:trains)
end

get("/rider/cities") do
  @cities = City.all()
  erb(:cities)
end


get('/rider/trains/:id') do
  id = params.fetch("id").to_i()
  train = Train.find(id)
  @cities = train.cities()
  erb(:train)
end

get('/operator/schedule') do
  @trains = Train.all()
  @cities = City.all()
  erb(:schedule)
end

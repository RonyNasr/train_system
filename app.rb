require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/trains')
require('./lib/cities')
require('pg')

DB = PG.connect({:dbname => "train_system"})

get('/') do
  erb(:index)
end

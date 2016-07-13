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

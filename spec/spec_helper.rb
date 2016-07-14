require('rspec')
require('pg')
require('train')
require('city')
require('schedule')
require('pry')

DB = PG.connect({:dbname => 'train_system_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM trains *;')
    DB.exec('DELETE FROM cities *;')
    DB.exec('DELETE FROM cities_trains *;')
  end
end

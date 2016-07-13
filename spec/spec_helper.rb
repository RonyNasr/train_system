require('rspec')
require('pg')
require('trains')
require('cities')

DB = PG.connect({:dbname => 'train_system'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM trains *;')
    DB.exec('DELETE FROM cities *;')
    DB.exec('DELETE FROM cities_trains *;')
  end
end

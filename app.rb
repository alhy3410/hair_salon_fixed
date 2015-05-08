require('sinatra')
require('sintra/reloader')
require('./lib/clients')
require('./lib/stylists')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => 'hair_salon'})

get('/')
  erb(:index)
end

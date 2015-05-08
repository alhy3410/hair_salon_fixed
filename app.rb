require('sinatra')
require('sinatra/reloader')
require('./lib/clients')
require('./lib/stylists')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => 'hair_salon_test'})

get('/') do
  erb(:index)
end

get('/hairsalon/stylists') do
  @stylists = Stylists.all()
  erb(:stylists)
end

# get('/hairsalon/clients/new') do
#   erb(:client_form)
# end


get('/hairsalon/stylists/new') do
  erb(:stylist_form)
end

post('/hairsalon/stylists') do
  name = params.fetch('name')
  @stylists = Stylists.new({:name => name})
  @stylists.save()
  erb(:success)
end

get('/hairsalon/stylists/:id/clients/new') do
  @stylist = Stylists.find(params.fetch('id').to_i())
  erb(:client_form)
end

get('/hairsalon/stylists/:id/clients') do
  @clients = Clients.all()
  @stylist = Stylists.find(params.fetch('id').to_i())
  erb(:clients)
end


post('/hairsalon/stylists/:id/clients') do
  name = params.fetch('name')
  stylist_id = params.fetch('stylist_id')
  @clients = Clients.new({:name => name, :stylists_id => stylist_id})
  @clients.save()
  erb(:success)
end

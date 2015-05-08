require('sinatra')
require('sinatra/reloader')
require('./lib/clients')
require('./lib/stylists')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => 'hair_salon'})

get('/') do
  erb(:index)
end

get('/stylists') do
  @stylists = Stylists.all()
  erb(:stylists)
end

get('/clients/new') do
  @stylist = Stylists.find(params.fetch('id').to_i())
  erb(:client_form)
end


get('/stylists/new') do
  erb(:stylist_form)
end

post('/stylists') do
  name = params.fetch('name')
  @stylist = Stylists.new({:name => name})
  @stylist.save()
  erb(:success)
end

get('/stylists/:id/clients/new') do
  @clients = Clients.all()
  erb(:clients)
end

post('/stylists/:id/clients') do
  @stylist = Stylists.find(params.fetch('id').to_i())
  erb(:clients)
end


post('/stylists/:id/clients') do
  name = params.fetch('name')
  stylist_id = params.fetch('stylist_id')
  @clients = Clients.new({:name => name, :stylists_id => stylist_id})
  @clients.save()
  erb(:clients)
end

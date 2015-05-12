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

get('/stylists/new') do
  erb(:stylist_form)
end

post('/stylists') do
  name = params.fetch('name')
  @stylist = Stylists.new({:name => name})
  @stylist.save()
  erb(:success)
end

get('/stylists/:id/list_clients') do
  @stylists = Stylists.find(params.fetch('id').to_i())
  erb(:clients_list)
end

get('/stylists/:id/add_clients') do
  @stylists = Stylists.find(params.fetch('id').to_i)
  erb(:client_form)
end

post('/stylists/:id/list_clients') do
  name = params.fetch('name')
  stylists_id = params.fetch('id').to_i()
  @stylists = Stylists.find(stylists_id)
  @client = Clients.new({:name => name, :stylists_id => stylists_id})
  @client.save()
  erb(:clients_list)
end

patch('/stylists/:id/list_clients') do
  stylists_name = params.fetch('stylists_name')
  @stylists = Stylists.find(params.fetch('id').to_i)
  @stylists.update({:name => stylists_name})
  erb(:clients_list)
end

delete('/stylists/:id/list_clients') do
  @stylists = Stylists.find(params.fetch('id').to_i)
  @stylists.delete()
  @stylists = Stylists.all
  erb(:stylists)
end

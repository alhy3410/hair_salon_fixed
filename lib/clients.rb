class Clients
  attr_reader(:name,:id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    all_clients = DB.exec("SELECT * FROM clients; ")
    clients_list = []
    all_clients.each() do |client|
      name = client.first().fetch('name')
      id = client.first().fetch('id')
      clients_list.push(Clients.new({:name => name}))
    end
    clients_list
  end
end

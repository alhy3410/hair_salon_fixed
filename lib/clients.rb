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
      name = client.fetch('name')
      id = client.fetch('id').to_i()
      clients_list.push(Clients.new({:name => name, :id => id}))
    end
    clients_list
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (name) VALUES ('#{name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_client|
    self.name().==(another_client.name())
  end

  define_singleton_method(:find) do |id|
    found_client = nil
    Clients.all().each() do |client|
      if client.id().==(id)
        found_client = client
      end
    end
    found_client
  end

end

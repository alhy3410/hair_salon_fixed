class Clients
  attr_reader(:name,:id,:stylists_id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
    @stylists_id = attributes[:stylists_id] ||= "NULL"
  end

  define_singleton_method(:all) do
    all_clients = DB.exec("SELECT * FROM clients; ")
    clients_list = []
    all_clients.each() do |client|
      name = client.fetch('name')
      id = client.fetch('id').to_i()
      stylists_id = client.fetch('stylists_id').to_i()
      clients_list.push(Clients.new({:name => name, :id => id, :stylists_id => stylists_id}))
    end
    clients_list
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (name, stylists_id) VALUES ('#{@name}', #{@stylists_id}) RETURNING id;")
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

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE clients SET name = '#{@name}' WHERE id = #{@id};")
  end



end

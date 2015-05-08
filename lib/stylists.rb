class Stylists
  attr_reader(:name,:id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    all_stylists = DB.exec("SELECT * FROM stylists;")
    stylists_list = []
    all_stylists.each() do |stylist|
      name = stylist.fetch('name')
      id = stylist.fetch('id').to_i()
      stylists_list.push(Stylists.new({:name => name, :id => id}))
    end
    stylists_list
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i
  end

  define_method(:==) do |another_stylist|
    self.name().==(another_stylist.name())
  end

  define_singleton_method(:find) do |identification|
    found_stylist = []
    Stylists.all().each() do |stylist|
      if stylist.id() == identification
        found_stylist = stylist
      end
    end
    found_stylist
  end
  
end

require('spec_helper')

describe('Stylists') do
  describe('#name') do
    it('will show the name of the stylist') do
      new_stylist = Stylists.new({:name => "Tim Buktoo"})
      expect(new_stylist.name()).to(eq("Tim Buktoo"))
    end
  end

  describe('.all') do
    it('will return an empty array which will hold all the stylists') do
    expect(Stylists.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('will save the stylist into the database') do
      new_stylist = Stylists.new({:name => "James Bond"})
      new_stylist.save()
      expect(Stylists.all()).to(eq([new_stylist]))
    end
  end

  describe('.find') do
    it('will find the stylist using the id') do
      new_stylist = Stylists.new({:name => "James Bond"})
      new_stylist.save()
      new_stylist2 = Stylists.new({:name => "James Rond"})
      new_stylist2.save()
      expect(Stylists.find(new_stylist2.id())).to(eq(new_stylist2))
    end
  end

  describe('#clients') do
    it('will show all the clients of the stylist') do
      new_stylist = Stylists.new({:name => "Bob Turner"})
      new_stylist.save()
      new_client = Clients.new({:name => "Tim Burton", :stylists_id => new_stylist.id()})
      new_client.save()
      expect(new_stylist.clients()).to(eq([new_client]))
    end
  end

end

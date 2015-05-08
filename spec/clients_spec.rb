require('spec_helper')

describe('Clients') do
  describe('#name') do
    it('will return the name of the client') do
      new_client = Clients.new({:name => "James Smith"})
      expect(new_client.name()).to(eq("James Smith"))
    end
  end

  describe('.all') do
    it('will return an empty array which will hold all the clients') do
      expect(Clients.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('will save the client name into the database') do
      new_client = Clients.new({:name => "James Smith"})
      new_client.save()
      expect(Clients.all()).to(eq([new_client]))
    end
  end

  describe('.find') do
    it('will find the client based on the id') do
      new_client = Clients.new({:name => "James Smith"})
      new_client.save()
      new_client2 = Clients.new({:name => "Tom Snap"})
      new_client2.save()
      expect(Clients.find(new_client.id())).to(eq(new_client))
    end
  end

  describe('#update') do
    it('will update the info in the clients database') do
      new_client = Clients.new({:name => "Tom Ford"})
      new_client.save()
      new_client.update({:name => "Robert Jones"})
      expect(new_client.name()).to(eq("Robert Jones"))
    end
  end
end

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
end

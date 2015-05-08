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
  

end

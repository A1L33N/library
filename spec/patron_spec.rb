require('spec_helper')

describe(Patron) do
  describe("#name") do
    it('will return the name of the patron') do
      patron1 = Patron.new({:id => nil, :name => 'Arya Stark'})
      expect(patron1.name).to(eq('Arya Stark'))
    end
  end
end

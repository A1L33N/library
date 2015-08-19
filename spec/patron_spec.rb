require('spec_helper')

describe(Patron) do
  describe("#name") do
    it('will return the name of the patron') do
      patron1 = Patron.new({:id => nil, :name => 'Arya Stark'})
      expect(patron1.name).to(eq('Arya Stark'))
    end
  end

  describe(".all") do
    it("will return an empty array at first") do
      expect(Patron.all).to(eq([]))
    end
  end

  describe("#save") do
    it("will save a patron to the patrons DB") do
      patron1 = Patron.new({:id => nil, :name => 'Arya Stark'})
      patron1.save
      expect(Patron.all()).to(eq([patron1]))
    end
  end

  describe('#==') do
    it("will compare items the way we want") do
      patron1 = Patron.new({:id => nil, :name => 'Arya Stark'})
      patron1.save
      expect(Patron.all()).to(eq([patron1]))
    end
  end

  # describe('.find') do
  #   it('locates a given instance of the book class by ID') do
  #     book1 = Book.new({:id => nil, :title => 'Ready Player One'})
  #     book1.save
  #     book2 = Book.new({:id => nil, :title => 'Chasing the Scream'})
  #     book2.save
  #     book3 = Book.new({:id => nil, :title => 'Eat, Pray, Love'})
  #     book3.save
  #     expect(Book.find(book2.id())).to(eq(book2))
  #   end
  # end
  #
  # describe('#delete') do
  #   it('deletes a specific instance of the Book class') do
  #     book1 = Book.new({:id => nil, :title => 'Ready Player One'})
  #     book1.save
  #     book2 = Book.new({:id => nil, :title => 'Chasing the Scream'})
  #     book2.save
  #     book3 = Book.new({:id => nil, :title => 'Eat, Pray, Love'})
  #     book3.save
  #     book3.delete()
  #     expect(Book.all()).to(eq([book1, book2]))
  #   end
  # end
  #
  # describe(".clear") do
  #   it('clears all the saved books') do
  #     book1 = Book.new({:id => nil, :title => 'Ready Player One'})
  #     book1.save
  #     book2 = Book.new({:id => nil, :title => 'Chasing the Scream'})
  #     book2.save
  #     book3 = Book.new({:id => nil, :title => 'Eat, Pray, Love'})
  #     book3.save
  #     Book.clear
  #     expect(Book.all).to(eq([]))
  #   end
  # end
end

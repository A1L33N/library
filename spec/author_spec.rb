require('spec_helper')


describe(Author) do
  describe("#name") do
    it('will return the name of the author') do
      author1 = Author.new({:id => nil, :name => 'Tyrion Lannister'})
      expect(author1.name).to(eq('Tyrion Lannister'))
    end
  end

  describe(".all") do
    it("will return an empty array at first") do
      expect(Author.all).to(eq([]))
    end
  end

  describe("#save") do
    it("will save an author to the patrons DB") do
      author1 = Author.new({:id => nil, :name => 'Tyrion Lannister'})
      author1.save
      author2 = Author.new({:id => nil, :name => 'Cersei Lannister'})
      author2.save
      expect(Author.all()).to(eq([author1, author2]))
    end
  end

  describe('#==') do
    it("will compare items the way we want") do
      author1 = Author.new({:id => nil, :name => 'Arya Stark'})
      author1.save
      expect(Author.all()).to(eq([author1]))
    end
  end

  describe('.find') do
    it('locates a given instance of a author class by ID') do
      author1 = Author.new({:id => nil, :name => 'Tyrion Lannister'})
      author1.save
      author2 = Author.new({:id => nil, :name => 'Cersei Lannister'})
      author2.save
      author3 = Author.new({:id => nil, :name => 'Jamie Lannister'})
      author3.save
      expect(Author.find(author2.id())).to(eq(author2))
    end
  end

  describe('#delete') do
    it('deletes a specific instance of the Author class') do
      author1 = Author.new({:id => nil, :name => 'Tyrion Lannister'})
      author1.save
      author2 = Author.new({:id => nil, :name => 'Cersei Lannister'})
      author2.save
      author3 = Author.new({:id => nil, :name => 'Jamie Lannister'})
      author3.save
      author3.delete()
      expect(Author.all()).to(eq([author1, author2]))
    end
  end

  describe(".clear") do
    it('clears all the saved authors') do
      author1 = Author.new({:id => nil, :name => 'Tyrion Lannister'})
      author1.save
      author2 = Author.new({:id => nil, :name => 'Cersei Lannister'})
      author2.save
      author3 = Author.new({:id => nil, :name => 'Jamie Lannister'})
      author3.save
      Author.clear
      expect(Author.all()).to(eq([]))
    end
  end

  describe('#update') do
    it('updates a given instance of the Author class') do
      author1 = Author.new({:id => nil, :name => 'Tyrion Lannister'})
      author1.save
      author1.update({:name => "Catlin Stark"})
      expect(author1.name()).to(eq("Catlin Stark"))
    end

    it('allows you to add a book to a author') do
      author1 = Author.new({:id => nil, :name => 'George RR Martin'})
      author1.save
      book1 = Book.new({:id => nil, :title => 'Game of Thrones'})
      book1.save
      book2 = Book.new({:id => nil, :title => 'The Winds of Winter'})
      book2.save
      author1.update({:book_ids => [book1.id(), book2.id()]})
      expect(author1.books()).to eq([book1, book2])
    end
  end

  describe("#books") do
    it('returns all the books of one author') do
      author1 = Author.new({:id => nil, :name => 'George RR Martin'})
      author1.save
      book1 = Book.new({:id => nil, :title => 'Game of Thrones'})
      book1.save
      book2 = Book.new({:id => nil, :title => 'The Winds of Winter'})
      book2.save
      author1.update({:book_ids => [book1.id(), book2.id()]})
      expect(author1.books()).to eq([book1, book2])
    end
  end
end

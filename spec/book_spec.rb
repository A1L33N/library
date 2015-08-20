# require('rspec')
# require('pry')
# require('book')
# require('pg')
#
# DB = PG.connect({:dbname => 'library_test'})
#
# RSpec.configure do |config|
#   config.after(:each) do
#     DB.exec("DELETE FROM books *;")
#   end
# end

require('spec_helper')

describe(Book) do
  describe("#title") do
    it(' will return the title of the book') do
      book1 = Book.new({:id => nil, :title => 'Ready Player One'})
      expect(book1.title).to(eq('Ready Player One'))
    end
  end

  describe(".all") do
    it("will return an empty array at first") do
      expect(Book.all).to(eq([]))
    end
  end

  describe("#save") do
    it("will save a book to the book DB") do
      book1 = Book.new({:id => nil, :title => 'Ready Player One'})
      book1.save
      expect(Book.all).to(eq([book1]))
    end
  end

  describe('#==') do
    it("will compare items the way we want") do
      book1 = Book.new({:id => nil, :title => 'Ready Player One'})
      book1.save
      expect(Book.all).to(eq([book1]))
    end
  end

  describe('.find') do
    it('locates a given instance of the book class by ID') do
      book1 = Book.new({:id => nil, :title => 'Ready Player One'})
      book1.save
      book2 = Book.new({:id => nil, :title => 'Chasing the Scream'})
      book2.save
      book3 = Book.new({:id => nil, :title => 'Eat, Pray, Love'})
      book3.save
      expect(Book.find(book2.id())).to(eq(book2))
    end
  end

  describe('#delete') do
    it('deletes a specific instance of the Book class') do
      book1 = Book.new({:id => nil, :title => 'Ready Player One'})
      book1.save
      book2 = Book.new({:id => nil, :title => 'Chasing the Scream'})
      book2.save
      book3 = Book.new({:id => nil, :title => 'Eat, Pray, Love'})
      book3.save
      book3.delete()
      expect(Book.all()).to(eq([book1, book2]))
    end
  end

  describe(".clear") do
    it('clears all the saved books') do
      book1 = Book.new({:id => nil, :title => 'Ready Player One'})
      book1.save
      book2 = Book.new({:id => nil, :title => 'Chasing the Scream'})
      book2.save
      book3 = Book.new({:id => nil, :title => 'Eat, Pray, Love'})
      book3.save
      Book.clear
      expect(Book.all).to(eq([]))
    end
  end

  describe('#update') do
    it('allows a user to update the title of a book') do
      book1 = Book.new({:id => nil, :title => 'Ready Player One'})
      book1.save
      book1.update({:title => "Ready Player Two"})
      expect(book1.title).to(eq("Ready Player Two"))
    end

    it('allows you to add an author to a book') do
      book1 = Book.new({:id => nil, :title => 'Ready Player One'})
      book1.save
      author1 = Author.new({:id => nil, :name => 'George RR Martin'})
      author1.save
      author2 = Author.new({:id => nil, :name => 'Orson Scott Card'})
      author2.save
      book1.update({:author_ids => [author1.id(), author2.id()]})
      expect(book1.authors()).to eq([author1, author2])
    end
  end

  describe("#authors") do
    it('returns all the authors of a book') do
      book1 = Book.new({:id => nil, :title => 'Ready Player One'})
      book1.save
      author1 = Author.new({:id => nil, :name => 'George RR Martin'})
      author1.save
      author2 = Author.new({:id => nil, :name => 'Orson Scott Card'})
      author2.save
      book1.update({:author_ids => [author1.id(), author2.id()]})
      expect(book1.authors()).to eq([author1, author2])

    end
  end
end

require('rspec')
require('pry')
require('book')
require('pg')

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
  end
end

describe(Book) do
  describe("#title") do
    it(' will return the title of the book') do
      book1 = Book.new({:id => nil, :title => 'Ready Player One'})
      expect(book1.title).to(eq('Ready Player One'))
    end
  end

end

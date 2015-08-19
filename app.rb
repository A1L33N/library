require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/author")
require("./lib/patron")
require("./lib/book")
require('pg')

DB = PG.connect({:dbname => "library"})

get('/') do
  erb(:index)
end

get('/books') do
  erb(:book_list)
end

post('/books') do
  new_book = Book.new(:id => nil, :title => params.fetch('new_book'))
  new_book.save
  erb(:book_list)


end

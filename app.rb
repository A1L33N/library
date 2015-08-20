require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/author")
require("./lib/patron")
require("./lib/book")
require('pg')
require('pry')

DB = PG.connect({:dbname => "library"})

get('/') do
  erb(:index)
end

get('/books') do
  @all_books = Book.all
  erb(:book_list)
end

post('/books') do
  new_book = Book.new({:id => nil, :title => params.fetch('new_book')})
  new_book.save
  @all_books = Book.all

  erb(:book_list)
end

get('/books/:id') do
  book_id= params.fetch('id').to_i
  @book = Book.find(book_id)
  erb(:book)
end

delete('/books/:id') do
  @book = Book.find(params.fetch('id').to_i)
  @book.delete()
  @all_books = Book.all
  erb(:book_list)
end

get('/patrons') do
  @all_patrons = Patron.all
  erb(:patron_list)
end

post('/patrons') do
  new_patron = Patron.new({:id => nil, :name => params.fetch('patron_name')})
  new_patron.save
  @all_patrons = Patron.all
  erb(:patron_list)
end

get('/patrons/:id') do
  @patron = Patron.find(params.fetch('id').to_i)
  erb(:patron)
end

delete('/patrons/:id') do
  patron = Patron.find(params.fetch('id').to_i)
  patron.delete
  @all_patrons = Patron.all
  erb(:patron_list)
end

get('/authors') do
  @all_authors = Author.all
  erb(:author_list)
end

post('/authors') do
  new_author = Author.new({:id => nil, :name => params.fetch('new_author')})
  new_author.save
  @all_authors = Author.all
  erb(:author_list)
end

get('/authors/:id') do
  id = params.fetch('id').to_i
  @author = Author.find(id)
  erb(:author)
end


delete('/authors/:id') do
  author = Author.find(params.fetch('id').to_i)
  author.delete
  @all_authors = Author.all
  erb(:author_list)
end

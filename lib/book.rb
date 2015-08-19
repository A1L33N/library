class Book
  attr_reader(:id, :title)

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    result = DB.exec("SELECT * FROM books;")
    returned_books = []
    result.each() do |book|
      title = book.fetch('title');
      id = book.fetch('id').to_i
      returned_books.push(Book.new({:id => id, :title => title}))
    end
    returned_books
  end

  define_method(:save) do
     result = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id")
     @id = result.first().fetch('id').to_i
  end

  define_method(:==) do |another_book|
    self.title() == another_book.title() && self.id() == another_book.id()
  end



end

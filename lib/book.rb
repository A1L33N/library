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
      title = books.fetch('title');
      id = books.fetch('id').to_i
      returned_books.push(Book.new({:id => id, :title => title}))
    end
    returned_books
  end






end

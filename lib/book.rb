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
     result = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
     @id = result.first().fetch('id').to_i
  end

  define_method(:==) do |another_book|
    self.title() == another_book.title() && self.id() == another_book.id()
  end

  define_singleton_method(:find) do |id_number|
    found_book = nil
    Book.all.each() do |book|
      if book.id == id_number
        found_book = book
      end
    end
    found_book
  end

  define_method(:delete) do
    DB.exec("DELETE FROM books WHERE id = #{self.id};")
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM books *;")
  end

  define_method(:update) do |attributes|
    @title= attributes.fetch(:title, @title)
    @id = self.id
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id};")

    attributes.fetch(:author_ids, []).each() do |author_id|
      DB.exec("INSERT INTO authors_books (author_id, book_id) VALUES (#{author_id}, #{self.id()});")
    end
  end

  define_method(:authors) do
    book_authors = []
    results = DB.exec("SELECT author_id FROM authors_books WHERE book_id = #{self.id()};")
    results.each() do |result|
      author_id = result.fetch('author_id').to_i
      author = DB.exec("SELECT * FROM authors WHERE id = #{author_id};")
      author_name = author.first.fetch("name")
      book_authors.push(Author.new({:name => author_name, :id => author_id}))
    end
    book_authors
  end
end

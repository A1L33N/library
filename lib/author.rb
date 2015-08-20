class Author
  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end


  define_singleton_method(:all) do
    result = DB.exec("SELECT * FROM authors;")
    all_authors = []
    result.each() do |author|
      name = author.fetch('name')
      id = author.fetch('id').to_i
      all_authors.push(Author.new({:id => id, :name => name}))
    end
    all_authors
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i
  end

  define_method(:==) do |another_author|
    self.name == another_author.name && self.id == another_author.id
  end

  define_singleton_method(:find) do |id|
    found_author = nil
    Author.all().each() do |author|
      if author.id == id
        found_author = author
      end
    end
    found_author
  end

  define_method(:delete) do
    DB.exec("DELETE FROM authors_books WHERE author_id = #{self.id};")
    DB.exec("DELETE FROM authors WHERE id = #{self.id};")
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM authors *;")
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE authors SET name = '#{@name}' WHERE id = #{@id}" )

    attributes.fetch(:book_ids, []).each() do |book_id|
      DB.exec("INSERT INTO authors_books (author_id, book_id) VALUES (#{self.id()}, #{book_id});")
    end
  end

  define_method(:books) do
    author_books = []
    results = DB.exec("SELECT book_id FROM authors_books WHERE author_id = #{self.id()};")
    results.each() do |book|
      book_id = book.fetch('book_id').to_i()
      book = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      book_title = book.first().fetch('title')
      author_books.push(Book.new({:title => book_title, :id => book_id}))
    end
    author_books
  end
end

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
    DB.exec("DELETE FROM authors WHERE id = #{self.id}")
  end
end

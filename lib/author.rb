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
end

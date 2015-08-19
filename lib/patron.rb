class Patron
  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_results = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_results.each() do |patron|
      name = patron.fetch("name")
      id = patron.fetch("id").to_i()
      patrons.push(Patron.new({:id => id, :name => name}))
    end
    patrons
  end

end

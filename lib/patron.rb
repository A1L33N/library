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

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i
  end

  define_method(:==) do |another_patron|
    self.name == another_patron.name && self.id == another_patron.id
  end

  define_singleton_method(:find) do |id_number|
    found_patron = nil
    Patron.all.each() do |patron|
      if patron.id == id_number
        found_patron = patron
      end
    end
    found_patron
  end

end

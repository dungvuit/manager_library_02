class Supports::Relationship
  def publishers
    @publishers = Publisher.all.collect {|publisher| [publisher.name, publisher.id]}
  end

  def authors
    @authors = Author.all.collect {|author| [author.name, author.id]}
  end

  def categories
    @categories = Category.all.collect {|category| [category.name, category.id]}
  end

  def books
    @books = Book.all.collect {|book| [book.name, book.id]}
  end
end

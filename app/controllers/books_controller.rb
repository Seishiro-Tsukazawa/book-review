class BooksController < ApplicationController
  
  def new
    @books = []
    @keyword = params[:keyword]
    
    if @keyword.present?
      results = RakutenWebService::Books::Book.search({
        title: @keyword,
        hits: 5
      })
      
      results.each do |result|
        book = Book.new(read(result))
        @books << book
      end
    end
  end

  def create
    @book = Book.find_or_initialize_by(isbn: params[:isbn])
    
    unless @book.persisted?
      result = RakutenWebService::Books::Book.search(isbn: @book.isbn)
      @item = Book.new(read(result.first))
      @item.save
      
      
    end
  end
  
  private
  
  def read(result)
    title = result['title']
    author = result['author']
    isbn = result['isbn']
    image = result['mediumImageUrl'].gsub('?_ex=120x120', '')
    
    
    {
      title: title,
      author: author,
      isbn: isbn,
      image: image
      
    }
  end
  
  
  
end

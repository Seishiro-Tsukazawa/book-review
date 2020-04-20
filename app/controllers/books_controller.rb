class BooksController < ApplicationController
  before_action :require_user_logged_in
  def new
    @books = []
    @keyword = params[:keyword]
    
    if @keyword.present? && @keyword.length > 1
      results = RakutenWebService::Books::Total.search({
        keyword: @keyword,
        hits: 16
      })
      
      results.each do |result|
        book = Book.new(read(result))
        @books << book
      end
    end
  end

  def create
    @book = Book.find_or_initialize_by(isbn: params[:isbn])
    
    if @book.persisted?
      redirect_to new_review_path(@book.isbn)
    else
      result = RakutenWebService::Books::Book.search(isbn: @book.isbn)
      @item = Book.new(read_for_save(result.first))
      if @item.save then redirect_to new_review_path(@book.isbn) end
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
  
  def read_for_save(result)
  
    
    title = result['title']
    author = result['author']
    isbn = result['isbn']
    publisher = result['publisherName']
    image = result['mediumImageUrl'].gsub('?_ex=120x120', '')
    
    {
      title: title,
      author: author,
      publisher: publisher,
      isbn: isbn,
      image: image
      
    }
    
  end
  
  
end

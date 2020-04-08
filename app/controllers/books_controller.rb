class BooksController < ApplicationController
  
  def new
    @keyword = params[:keyword]
    
    if @keyword.present?
      @results = RakutenWebService::Books::Book.search({
        title: @keyword,
        hits: 5
      })
    end
  end

  def create
  end
  
  private
  
  
  
end

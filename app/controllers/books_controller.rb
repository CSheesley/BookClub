class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
  end

  def new
    @book = Book.new
  end

  def index
    # binding.pry
    if params.include?("sort")
      binding.pry
      @books = Book.send params[:sort], params[:direction].to_sym
    else
      @books = Book.all
    end
  end

  def create
    book_info = book_params
    @authors = Author.authors_from_string(book_info.delete(:author_names))
    @book = Book.new_from_form(book_info)
    @book.authors = @authors
    @book.save
    redirect_to book_path(@book)
  end

  private

  def book_params
    params.require(:book).permit(:title, :author_names, :pages, :year, :cover)
  end
end

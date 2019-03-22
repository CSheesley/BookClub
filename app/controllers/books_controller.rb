class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @reviews = Review.where(book_id: params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    book_info = book_params
    # binding.pry
    @authors = Author.authors_from_string(book_info.delete(:author_names))
    @book = Book.new(book_info)
    @book.authors = @authors
    @book.save
    redirect_to book_path(@book)
  end

  private

  def book_params
    params.require(:book).permit(:title, :author_names, :pages, :year, :cover)
  end
end

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
    @authors = Author.authors_from_string(book_info.delete(:authors))
    @book = Book.new(book_info)
    @book.authors = @authors
    @book.save
    redirect_to book_path(@book)
  end

  private

  def book_params
    # binding.pry
    params.require(:book).permit(:title, :authors, :pages, :year, :cover)
  end
end

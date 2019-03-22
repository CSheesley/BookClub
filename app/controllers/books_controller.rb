class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.create(book_params)
  end

  private

  def book_params
    params.require(:book).permit(:title, :authors, :pages, :cover)
  end
end

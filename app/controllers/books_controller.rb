class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @reviews = Review.where(book_id: params[:id])
  end
end

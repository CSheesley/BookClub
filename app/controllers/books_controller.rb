class BooksController < ApplicationController
  def show
    @books = Book.find(params[:id])
  end
end

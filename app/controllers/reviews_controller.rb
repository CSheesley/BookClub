class ReviewsController < ApplicationController
  def index
    @user_name = params[:name]
    @reviews = Review.where(user: @user_name)
  end

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    # binding.pry
    @book = Book.find(params[:book_id])
    redirect_to book_path(@book)
  end

end

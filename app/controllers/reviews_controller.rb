class ReviewsController < ApplicationController
  def index
    # binding.pry
    @user_name = params[:user]
    direction = params[:direction]
    if direction == nil
      @reviews = Review.where(user: @user_name)
    else
      @reviews = Review.where(user:@user_name).sorted_by_time(direction.to_sym)
    end
  end

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new_from_form(review_params)
    redirect_to book_path(@book)
  end

private

  def review_params
    params.require(:review).permit(:title, :user, :rating, :text)
  end
end

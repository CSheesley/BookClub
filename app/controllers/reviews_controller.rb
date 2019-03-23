class ReviewsController < ApplicationController
  def index
    @user_name = params[:user]
    @reviews = Review.where(user: @user_name)
  end

  def new
    @review = Review.new
  end
end

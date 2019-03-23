class ReviewsController < ApplicationController
  def index
    @user_name = params[:name]
    @reviews = Review.where(user: @user_name)
  end
end

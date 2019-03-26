class Review < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :text
  validates_presence_of :rating
  validates_presence_of :user
  validates_inclusion_of :rating, :in => 1..5

  belongs_to :book

  def self.sorted_by_time(direction)
    order(created_at: direction)
  end

  def self.most_reviews
    select("user, count(user) as review_count").
    order("count(user) DESC").
    group(:user)
  end

  def self.avg_rating
    average(:rating)
  end

  def self.rating_sort(direction)
    order(rating: direction)
  end

  def self.total_reviews
    count
  end

  def self.new_from_form(review_info)
    review_info[:user] = review_info[:user].titleize
    create(review_info)
  end
end

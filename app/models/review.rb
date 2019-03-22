class Review < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :text
  validates_presence_of :rating
  validates_presence_of :user

  belongs_to :book

  def self.sorted_by_time(direction)
    order(created_at: direction)
  end

  def self.most_reviews
    group(:user).
    order("count(user) DESC").
    pluck(:user)
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
end

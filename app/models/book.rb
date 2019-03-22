class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :pages
  validates_presence_of :year
  validates_presence_of :cover

  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews

  def author_names
    authors.pluck(:name)
  end

  def co_authors(author)
    authors.where.not(id: author.id).pluck(:name)
  end
  def self.direction_hash
    {asc:"ASC",desc:"DESC"}
  end

  def self.sort_pages(direction)
    Book.order(pages: direction)
  end

  def self.sort_num_reviews(direction)

    select("books.*, count(*) AS rev_count")
    .joins(:reviews)
    .group(:id)
    .order("rev_count #{direction_hash[direction]}")
  end

  def self.sort_avg_reviews(direction)
    select("books.*, avg(rating) AS avg_rating")
    .joins(:reviews)
    .group(:id)
    .order("avg_rating #{direction_hash[direction]}")
  end
end

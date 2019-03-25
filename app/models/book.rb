class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :year
  validates_presence_of :cover
  validates :pages, presence: true, numericality: { greater_than: 0 }

  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews

  def author_names
    authors.pluck(:name)
  end

  def co_authors(author)
    authors.where.not(id: author.id)
  end

  def self.new_from_form(book_info)
    if book_info[:cover] == ""
      book_info[:cover] = "https://smartmobilestudio.com/wp-content/uploads/2012/06/leather-book-preview.png"
    end
      book_info[:title] = book_info[:title].titleize
    create(book_info)
  end

  def self.direction_hash
    {asc:"ASC", desc:"DESC"}
  end

  def self.sort_pages(direction)
    order(pages: direction)
  end

  def self.sort_num_reviews(direction)
    select("books.*")
    .joins(:reviews)
    .group(:id)
    .order("count(*) #{direction_hash[direction]}")
  end

  def self.sort_avg_reviews(direction)
    select("books.*")
    .joins(:reviews)
    .group(:id)
    .order("avg(reviews.rating) #{direction_hash[direction]}")
  end
end

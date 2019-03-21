class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :pages
  validates_presence_of :year
  validates_presence_of :cover
  validates :pages, numericality: { greater_than_or_equal_to: 1 }

  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews

  def author_names
    authors.pluck(:name)
  end

  def co_authors(author)
    authors.where.not(id: author.id).pluck(:name)
  end

  def self.new_from_form(book_info)
    if book_info[:cover] == ""
      book_info[:cover] = "https://smartmobilestudio.com/wp-content/uploads/2012/06/leather-book-preview.png"
    else
      book_info[:cover]
    end
    self.create(book_info)
  end
end

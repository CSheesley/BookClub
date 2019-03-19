class Author < ApplicationRecord
  validates_presence_of :name

  has_many :book_authors
  has_many :books, through: :book_authors

end

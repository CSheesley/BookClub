class Author < ApplicationRecord
  validates_presence_of :name

  has_many :book_authors
  has_many :books, through: :book_authors

  def self.authors_from_string(author_string)
    string_list = author_string.split(",")
    string_list.map do |string|
      self.create(name: string.strip.titleize)
    end
  end
end

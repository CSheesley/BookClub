class Author < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :book_authors
  has_many :books, through: :book_authors

  def self.authors_from_string(author_string)
    string_list = author_string.split(",")
    string_list.map do |string|
      if string.strip.titleize != ''
        self.find_or_create_by(name: string.strip.titleize)
      end
    end.compact
  end
end

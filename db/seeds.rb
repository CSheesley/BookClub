# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'csv'
require 'pry'

options_hash = {col_sep: "\t", headers: true,
  header_converters: :symbol, converters: :numeric}

books = CSV.open('db/data/books.tsv', options_hash)
reviews = CSV.open('db/data/reviews.tsv', options_hash)
book_hashes = books.map{ |row| row.to_hash }
review_hashes  = reviews.map{ |row| row.to_hash }

book_hashes = book_hashes.each do |hash|
  hash[:authors] = hash[:authors].gsub(/[^a-zA-Z\s,]/,'').split(",")
end

book_hashes.each do |hash|
  authors = Author.authors_from_string(hash.delete(:authors).join(","))
  hash.delete(:cover_file)
  book = Book.create(hash)
  book.authors = authors
end

review_hashes.each do |hash|
  hash[:title] = hash.delete(:book_title)
  hash[:text] = hash.delete(:review)
  book = Book.where(title: hash.delete(:book_title))[0]
  book.reviews.create(hash)
end

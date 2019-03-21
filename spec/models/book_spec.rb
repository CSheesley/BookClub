require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :title}
    it { should validate_presence_of :pages}
    it { should validate_presence_of :year}
    it { should validate_presence_of :cover}
  end

  describe 'Relationships' do
    it { should have_many :book_authors }
    it { should have_many(:authors).through :book_authors }
    it { should have_many :reviews }
  end

  describe 'Instance Method' do
    it "new .author_names method; returns a list of strings(names)" do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
      book_2 = author_2.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
      book_2.authors << author_3
      book_3 = author_2.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      expect(book_1.author_names).to eq(["J.R.R Tolkein"])
      expect(book_2.author_names).to eq(["William Peterson", "Corey Sheesley"])
    end

    it "it can get a list of co-author names" do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
      book_2 = author_2.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
      book_2.authors << author_3
      book_3 = author_2.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      expect(book_1.co_authors(author_1)).to eq([])
      expect(book_2.co_authors(author_2)).to eq(["Corey Sheesley"])
    end
  end

  describe 'Class Method' do
    it ".sort_pages can sort books by number of pages, When given a symbol of :asc of :desc" do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = author_1.books.create(title: "The Hobbit", pages: 300, year: 1999, cover: "madeupurl.com")
      book_2 = author_2.books.create(title: "Title_2", pages: 450, year: 1998, cover: "othermadeupurl.com")
      book_2.authors << author_3
      book_3 = author_2.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      ascending_pages = Book.sort_pages(:asc)
      decending_pages = Book.sort_pages(:desc)

      expect(ascending_pages).to eq([book_1, book_3, book_2])
      expect(decending_pages).to eq([book_2, book_3, book_1])
    end

    it '.sort_num_reviews can sort books by number of reviews, when given a symbol of :asc or :desc' do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
      book_2 = author_2.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
      book_2.authors << author_3
      book_3 = author_2.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")
      review_2 = book_2.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")
      review_3 = book_2.reviews.create(title: "If you have too" , text: "Meh", rating: 4, user: "User_2")
      review_4 = book_3.reviews.create(title: "Data Pro" , text: "What a list!", rating: 2, user: "User_2")
      review_5 = book_3.reviews.create(title: "Meh", text: "no doubt", rating: 1, user: "User_1")
      review_6 = book_2.reviews.create(title:"Mediocre", text: "But surely passable", rating: 5, user: "User_3")

      ascending_num_reviews = Book.sort_num_reviews(:asc)
      descending_num_reviews = Book.sort_num_reviews(:desc)

      expect(ascending_num_reviews).to eq([book_1, book_3, book_2])
      expect(ascending_num_reviews).to eq([book_2, book_3, book_1])
    end

    it '.sort_avg_reviews can sort books by average rating of reviews, when given a symbol of :asc or :desc' do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
      book_2 = author_2.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
      book_2.authors << author_3
      book_3 = author_2.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")
      review_2 = book_2.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")
      review_3 = book_2.reviews.create(title: "If you have too" , text: "Meh", rating: 4, user: "User_2")
      review_4 = book_3.reviews.create(title: "Data Pro" , text: "What a list!", rating: 2, user: "User_2")
      review_5 = book_3.reviews.create(title: "Meh", text: "no doubt", rating: 1, user: "User_1")
      review_6 = book_2.reviews.create(title:"Mediocre", text: "But surely passable", rating: 5, user: "User_3")

      ascending_avg_reviews = Book.sort_avg_reviews(:asc)
      descending_avg_reviews = Book.sort_avg_reviews(:desc)

      expect(ascending_avg_reviews).to eq([book_1, book_3, book_2])
      expect(ascending_avg_reviews).to eq([book_2, book_3, book_1])
    end
  end
end

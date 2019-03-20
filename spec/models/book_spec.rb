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

  describe 'Class Method' do
    it "overrides the .authors method; returns a list of strings(names)" do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
      book_2 = author_2.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
      book_2.authors << author_3
      book_3 = author_2.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      expect(book_1.authors).to eq(["J.R.R Tolkein"])
      expect(book_2.authors).to eq(["William Peterson", "Corey Sheesley"])
    end
  end
end

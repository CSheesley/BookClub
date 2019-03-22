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

    it 'can populate a default cover image link if no image is provided' do
      book_info_1 = ({title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com"})
      book_info_2 = ({title: "Blank Book", pages: 100, year: 1980, cover: ""})

      default_image = "https://smartmobilestudio.com/wp-content/uploads/2012/06/leather-book-preview.png"

      book_1 = Book.new_from_form(book_info_1)
      book_2 = Book.new_from_form(book_info_2)

      expect(book_1.cover).to eq("madeupurl.com")
      expect(book_2.cover).to eq(default_image)
    end

    it 'will not create a book if the page count is less than 1 page' do
      book_info_1 = ({title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com"})
      book_info_2 = ({title: "Bad Example", pages: 1, year: 1980, cover: "madeupurl.com"})
      book_info_3 = ({title: "Worse Example", pages: 0, year: 1981, cover: "madeupurl.com"})
      book_info_3 = ({title: "Worse Example", pages: -10, year: 1981, cover: "madeupurl.com"})
      book_info_4 = ({title: "Worsest Example", pages: -10, year: 1981, cover: "madeupurl.com"})

      book_1 = Book.new_from_form(book_info_1)
      book_2 = Book.new_from_form(book_info_2)
      book_3 = Book.new_from_form(book_info_3)
      book_4 = Book.new_from_form(book_info_4)

      expect(Book.count).to eq(2)
    end
  end
end

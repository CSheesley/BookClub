require 'rails_helper'

RSpec.describe 'book partial render', type: :view do
  it 'Should render the view of a book with one author' do
    author_1 = Author.create(name: "J.R.R Tolkein")

    book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")

    render book_1

    # binding.pry

    expect(response).to have_xpath("//div[@id='book-card-#{book_1.id}']")
    within "#book-card-#{book_1.id}" do
      expect(response).to have_content(book_1.titlea)
      expect(response).to have_content("Author(s): #{book_1.author_names.join(", ")}")
      expect(response).to have_content("Pages: #{book_1.pages}")
      expect(response).to have_content("Year of Publication: #{book_1.year}")
      expect(response).to have_xpath("//img[@src='#{book_1.cover}']")
    end

  end

  it 'Should render the view of a book with two authors' do
    author_2 = Author.create(name: "William Peterson")
    author_3 = Author.create(name: "Corey Sheesley")

    book_2 = author_2.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
    book_2.authors << author_3
    render book_2

    # binding.pry
    expect(response).to have_xpath("//div[@id='book-card-#{book_2.id}']")
    within "#book-card-#{book_2.id}" do
      expect(response).to have_content(book_2.title)
      expect(response).to have_content("Author(s): #{book_2.author_names.join(", ")}")
      expect(response).to have_content("Pages: #{book_2.pages}")
      expect(response).to have_content("Year of Publication: #{book_2.year}")
      expect(response).to have_xpath("//img[@src='#{book_2.cover}']")
    end
  end
end

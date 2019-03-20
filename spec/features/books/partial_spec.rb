require 'rails_helper'

RSpec.describe 'book partial render', type: :view do
  it 'Should render the view of a book' do
    author_1 = Author.create(name: "J.R.R Tolkein")
    author_2 = Author.create(name: "William Peterson")
    author_3 = Author.create(name: "Corey Sheesley")

    book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
    book_2 = author_2.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
    book_2.authors << author_3

    review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")
    review_2 = book_2.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")
    review_3 = book_2.reviews.create(title: "If you have too" , text: "Meh", rating: 3, user: "User_2")

    render book_1

    expect(response).to have_content(book_1.title)
    expect(response).to have_content("Author(s): #{book_1.author_names.join(", ")}")
    expect(response).to have_content("Pages: #{book_1.pages}")
    expect(response).to have_content("Year of Publication: #{book_1.year}")
    expect(response).to have_xpath("//img[@src='#{book_1.cover}']")

  end
end

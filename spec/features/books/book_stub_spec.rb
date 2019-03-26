require 'rails_helper'

RSpec.describe 'book stub partial render', type: :view do
  it 'Should render the title (as link) and avg rating for a book' do
    author_1 = Author.create(name: "J.R.R Tolkein")
    book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
    review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")
    review_2 = book_1.reviews.create(title: "Nice Read" , text: "Very enjoyable", rating: 4, user: "User_1")

    render 'application/book_stub', book: book_1

    expect(rendered).to have_selector('div', id:"book-stub-#{book_1.id}")
    expect(rendered).to have_selector('span', id:'book-title', text: book_1.title)
    expect(rendered).to have_selector('span', id:'book-rating', text: book_1.average_rating)
    expect(rendered).to have_link(book_1.title, href:book_path(book_1))

  end
end

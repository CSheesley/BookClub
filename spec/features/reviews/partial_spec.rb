require 'rails_helper'

RSpec.describe 'review partial render', type: :view do
  it 'Should render the view of a review' do
    author_1 = Author.create(name: "J.R.R Tolkein")
    book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
    review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")

    render review_1

    expect(response).to have_xpath("//div[@id='review-#{review_1.id}']")
    within "#review-#{review_1.id}" do
      expect(response).to have_content(review_1.title)
      expect(response).to have_content(review_1.text)
      expect(response).to have_content(review_1.rating)
      expect(response).to have_content(review_1.user)
    end

  end
end

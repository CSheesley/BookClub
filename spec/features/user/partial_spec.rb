require 'rails_helper'

RSpec.describe 'user partial render', type: :view do
  it 'Should correctly give the link to user page' do
    book_1 = Book.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
    review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")

    render 'application/user', user: review_1.user
    expect(rendered).to have_link(review_1.user, href:reviews_path(user: review_1.user))
    expect(rendered).to have_selector('div', id: "user-#{review_1.user}")

  end
end

require 'rails_helper'

RSpec.describe 'user partial render', type: :view do
  it 'Should correctly give the link to user page' do
    book_1 = Book.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
    review_1 = book_1.reviews.create(title: "Great Book" , text: "What an adventure", rating: 5, user: "User_1")

    render user, user: review_1.user

    expect(response).to have_xpath("//div[@id='user-#{review_1.user}']")
    within "#user-#{review_1.user}" do
      expect(response).to have_content(review_1.user)
      expect(response).to have_xpath("//a[@href='#{reviews_path(user: review_1.user)}']")
    end
  end
end

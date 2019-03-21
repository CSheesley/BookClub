require 'rails_helper'

RSpec.describe 'new book workflow', type: :feature do
  context 'as a user' do
    it 'shows a form to fill out with the following fields: Title, Author(s), Pages, Cover' do

      visit new_book_path

      expect(page).to have_content("Title")
      expect(page).to have_content("Author")
      expect(page).to have_content("Pages")
      expect(page).to have_content("Cover")
    end

    it 'should accept input for a new book with one author, and redirected to that show page after clicking Create Book' do
      book_title = "The Davinci Code"
      book_pages = "350"
      book_year = "1995"
      book_cover = "madeupurl.com"
      book_authors = "Dan Brown"

      visit new_book_path

      fill_in 'book[title]', with: book_title
      fill_in 'book[pages]', with: book_pages
      fill_in 'book[authors]', with: book_authors

      click_button 'Create Book'

      book = Book.last
      expect(current_path).to eq(book_path(book))
    end

    it 'should redirect to a show page after accepting input' do
      book_title = "The Davinci Code"
      book_pages = "350"
      book_year = "1995"
      book_cover = "madeupurl.com"
      book_authors = "Dan Brown"

      visit new_book_path
      click_button 'Create Book'

      book = Book.last
      expect(current_path).to eq("/books/#{book.id}")
    end
  end
end

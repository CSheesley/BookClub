require 'rails_helper'

RSpec.describe 'new book workflow', type: :feature do
  context 'as a user visiting the book index page' do
    it 'shows have an add book link, which takes me to a form to fill out' do

      visit '/books'

      click_button 'Add Book'

      expect(current_path).to eq(new_book_path)

      expect(page).to have_content("Title")
      expect(page).to have_content("Author")
      expect(page).to have_content("Pages")
      expect(page).to have_content("Cover")
    end
  end

  context 'as a user filling out a new book form' do

    it 'should accept input for a new book with one or more authors, and redirected to that show page after clicking Create Book' do
      book_title = "The Davinci Code"
      book_pages = 350
      book_year = 1995
      book_cover = "madeupurl.com"
      book_authors = "Dan Brown, corey sheesley"

      visit new_book_path

      fill_in 'book[title]', with: book_title
      fill_in 'book[pages]', with: book_pages
      fill_in 'book[authors]', with: book_authors
      fill_in 'book[year]', with: book_year
      fill_in 'book[cover]', with: book_cover
      
      click_button 'Create Book'

      book = Book.last
      expect(current_path).to eq(book_path(book))
    end

    it 'adds a new book to an existing author, otherwise it adds a new author' do
      author_1 = Author.create(name: "Dan Brown")

      visit new_book_path

      book_title = "The Davinci Code"
      book_pages = 350
      book_year = 1995
      book_cover = "madeupurl.com"
      book_authors = "Dan Brown"

      fill_in 'book[title]', with: book_title
      fill_in 'book[pages]', with: book_pages
      fill_in 'book[authors]', with: book_authors
      fill_in 'book[year]', with: book_year
      fill_in 'book[cover]', with: book_cover

      click_button 'Create Book'

      expect(Author.count).to eq(1)
      expect(Author.first.books.count).to eq(1)
    end
  end
end

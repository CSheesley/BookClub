require 'rails_helper'

RSpec.describe 'navbar', type: :feature do
  context 'as a visitor to the website' do
    it 'should have a navbar with a link to all books index' do

    visit root_path

      within 'body' do

        expect(page).to have_content("Welcome to BookClub")
      end

      within '#nav-bar' do
        click_link 'All Books'
        expect(current_path).to eq(books_path)
      end
    end

    it 'should have a nav bar with a link back to the welcome page' do

    visit books_path

      within '#navbar' do
        click_link 'BookClub'
        expect(current_path).to eq('/')
      end
    end
  end
end

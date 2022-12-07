require 'rails_helper'

RSpec.describe "Welcome", type: :feature do
  scenario 'index page' do
    visit root_path
    expect(page).to have_content('Home')  
  end
    
  feature 'Visitor searches' do
    scenario 'with valid city' do
      search_with 'Berlin'
      expect(page).to have_content('Key')
    end
      
    def search_with(query)
      visit root_path
      fill_in "q", with: query
      click_button 'Search'
    end
  end
end
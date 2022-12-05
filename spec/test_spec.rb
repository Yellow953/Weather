require 'rails_helper'

RSpec.describe "Welcome", type: :feature do
    scenario 'index page' do
        visit root_path
        expect(page).to have_content('Welcome')  
    end
    
    feature 'Visitor signs in' do
        scenario 'with valid email and password' do
          sign_in_with 'test@test.com', 'qwe123bnm'
      
          expect(page).to have_content('Log in')
        end
      
        scenario 'with invalid email' do
          sign_in_with 'test1@test.com', 'password'
      
          expect(page).to have_content('Log in')
        end
      
        scenario 'with blank password' do
          sign_in_with 'test@test.com', ''
      
          expect(page).to have_content('Log in')
        end
      
        def sign_in_with(email, password)
          visit new_user_session_path
          fill_in 'Email', with: email
          fill_in 'Password', with: password
          click_button 'Log in'
        end
    end
end
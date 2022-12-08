require 'rails_helper'

RSpec.describe "Welcome", type: :feature do
  scenario 'index page' do
    visit root_path
    expect(page).to have_content('Home')  
  end
    
  it "assigns @results" do
    result = Result.create(key: 123, name: "berlin", category: "rainy", text: "hello world", average: 1, minimum:1, maximum:1)
    get :index
    expect(assigns(:results)).to eq([result])
  end

  it "is valid with valid attributes" do
    expect(Result.new).to be_valid
  end
end
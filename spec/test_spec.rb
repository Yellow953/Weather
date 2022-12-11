require 'rails_helper'

RSpec.describe "Welcome", type: :feature do
  scenario 'index page' do
    visit root_path
    expect(page).to have_content('Home')  
  end

  it "is valid with valid attributes" do
    expect(Result.new(key: 123, name: "berlin", category: "rainy", text: "hello world", average: 1, minimum:1, maximum:1)).to be_valid
  end

  # ----------------------------------
  let(:mail) { WeatherMailer.daly_weather }

  it "renders the headers" do
    expect(mail.subject).to eq("Daily Weather")
    expect(mail.to).to eq(["joemazloum953@gmail.com"])
    expect(mail.from).to eq(["joemazloum953@gmail.com"])
  end

  it "renders the body" do
    expect(mail.body.encoded).to match("Average")
  end

end
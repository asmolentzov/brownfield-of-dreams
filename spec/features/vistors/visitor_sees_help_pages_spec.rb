require 'rails_helper'

describe 'As a visitor to the site' do
  it 'can see Get Started page' do
    visit get_started_path
    
    expect(page).to have_content('Get Started')
    expect(page).to have_link('homepage', count: 2)
  end
  it 'can see About page' do
    visit about_path
    
    expect(page).to have_content('Turing Tutorials')
    expect(page).to have_content("This application is designed to pull in youtube information to populate tutorials from Turing School of Software and Design's youtube channel.")
  end
end
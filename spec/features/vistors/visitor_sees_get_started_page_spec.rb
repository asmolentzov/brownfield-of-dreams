require 'rails_helper'

describe 'As a visitor to the site' do
  it 'can see Get Started page' do
    visit get_started_path
    
    expect(page).to have_content('Get Started')
    expect(page).to have_link('homepage', count: 2)
  end
end
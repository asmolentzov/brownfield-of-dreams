require 'rails_helper'

describe 'As a logged in user' do
  describe 'When I visit my dashboard' do
    it 'should show me a list of GitHub repositories', :vcr do
      user = create(:user, token: ENV['GITHUB_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      visit dashboard_path
      
      expect(page).to have_content("Github")
      
      within(".github") do
        expect(page).to have_css(".repository", count: 5)
      end
      
      within first(".repository") do
        expect(page).to have_css(".name-link")
      end
    end
  end
end

# 
# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
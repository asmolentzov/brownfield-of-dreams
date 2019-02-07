require 'rails_helper'

describe 'as an admin' do
  describe 'when I visit new tutorial path' do
    it "will see a form" do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_tutorial_path

      expect(page).to have_field('Title')
      expect(page).to have_field('Description')
      expect(page).to have_field('Thumbnail')

      fill_in :tutorial_title, with: 'How to tie your shoes'
      fill_in :tutorial_description, with: 'Instructional videos'
      fill_in :tutorial_thumbnail, with: 'http://cdn3-www.dogtime.com/assets/uploads/2011/03/puppy-development-460x306.jpg'

      click_on 'Save'

      tutorial = Tutorial.last

      expect(current_path).to eq(tutorial_path(tutorial.id))
      expect(page).to have_content('Successfully created tutorial.')
      expect(page).to have_content('How to tie your shoes')
    end
    it 'should not create tutorial if fields are not filled in' do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_tutorial_path

      click_on 'Save'

      expect(page).to have_content("Unable to create tutorial")
    end
  end
end

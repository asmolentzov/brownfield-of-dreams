require 'rails_helper'

describe 'visitor sees a video show' do
  it 'vistor clicks on a tutorial title from the home page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit '/'

    click_on tutorial.title

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content(video.title)
    expect(page).to have_content(tutorial.title)
  end
  it 'vistor sees a tutorial show page even if there are no videos' do
    tutorial = create(:tutorial)

    visit '/'

    click_on tutorial.title

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content(tutorial.title)
  end
  it 'visitor sees tooltip when they hover over bookmark' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit '/'

    click_on tutorial.title

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content(video.title)
    expect(page).to_not have_link("Bookmark")
    within '.tooltip' do
      expect(page).to have_css('.tooltiptext')
    end
    within '.tooltiptext' do
      expect(page).to have_content('User must login to bookmark videos.')
    end
  end
end

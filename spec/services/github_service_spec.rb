require 'rails_helper'

describe GithubService do
  it 'exists' do
    user = create(:user)
    github_service = GithubService.new(user)
    
    expect(github_service).to be_a(GithubService)
  end
  
  it 'can return repositories', :vcr do
    user = create(:user, token: ENV['GITHUB_TOKEN'])
    github_service = GithubService.new(user)
    
    repos = github_service.repositories_by_user
    
    expect(repos.count).to eq(30)
    expect(repos.first).to have_key(:name)
    expect(repos.first).to have_key(:html_url)
  end
end
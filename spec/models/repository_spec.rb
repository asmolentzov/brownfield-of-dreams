require 'rails_helper' 

describe Respository do
  it 'exists' do
    attributes = {}
    repo = Repository.new(attributes)
    
    expect(repo).to be_a(Repository)
  end
  
  it 'has attributes' do
    attributes = { name: 'my_repo', 
                   html_url: "https://github.com/username/activerecord_repo"
                 }
    repo = Repository.new(attributes)
    expect(repo.name).to eq('my_repo')
    expect(repo.html_url).to eq('https://github.com/username/activerecord_repo')
  end
end
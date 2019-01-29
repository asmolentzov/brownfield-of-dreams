class GithubFacade

  def initialize(user)
    @user = user
  end
  
  def repos(quantity)
    results = GithubService.new(@user).repositories_by_user
    
    results.map.with_index do |raw_repo, index|
      if index < 5
        Repository.new(raw_repo)
      else 
        nil
      end
    end.compact
  end
end

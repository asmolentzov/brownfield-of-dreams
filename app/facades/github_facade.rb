class GithubFacade

  def initialize(user)
    @user = user
  end
  
  def repos(quantity)
    results = GithubService.new(@user).repositories_by_user
    repositories = []
    quantity.times do |raw_repo|
      repositories << Repository.new(results.shift)
    end
    repositories
  end
end

class GithubService
  def initialize(user)
    @user = user
  end

  def repos_by_user
    get_json('user/repos')
  end

  def followers_by_user
    get_json('user/followers')
  end
  
  def following_by_user
    get_json('user/following')
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = @user.github_token
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end

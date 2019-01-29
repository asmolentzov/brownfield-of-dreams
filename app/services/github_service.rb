class GithubService
  def initialize(user)
    @user = user
  end
  
  def repositories_by_user
    response = conn.get("user/repos")
    
    JSON.parse(response.body, symbolize_names: true)
  end
  
  private
  
  def conn
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Accept"] = "application/vnd.github.v3+json"
      faraday.headers["Authorization"] = @user.token
      faraday.adapter Faraday.default_adapter
    end
  end
end
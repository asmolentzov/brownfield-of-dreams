class UsersController < ApplicationController
  def show
    results = GithubService.new(current_user).repositories_by_user
    
    @repos = results.map do |raw_repo|
      Repository.new(raw_repo)
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end

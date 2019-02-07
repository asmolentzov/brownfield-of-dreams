class UsersController < ApplicationController
  def show
    @facade = DashboardFacade.new(current_user) if current_user.github_token
    @bookmarked_tutorials = Tutorial.bookmarked(current_user)
  end

  def new
    @user = User.new
  end

  def create
    if new_user.save
      create_user
    else
      user_error
    end
  end

  private
  
  def new_user
    @_user ||= User.create(user_params)
  end
  
  def create_user
    session[:user_id] = new_user.id
    flash[:success] = "Logged in as #{new_user.first_name} #{new_user.last_name}"
    flash[:notice] = 'This account has not yet been activated. Please check your email.'
    ActivationMailer.activation(current_user).deliver_now
    redirect_to dashboard_path
  end
  
  def user_error
    flash[:error] = 'Username already exists'
    @user = new_user
    render :new
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end

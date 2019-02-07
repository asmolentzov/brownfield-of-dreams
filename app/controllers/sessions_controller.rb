class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    if user && user.authenticate(params[:session][:password])
      create_session
    else
      login_error
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  
  def user
    @_user = User.find_by(email: params[:session][:email])
  end
  
  def create_session
    session[:user_id] = user.id
    redirect_to dashboard_path
  end
  
  def login_error
    flash[:error] = "Looks like your email or password is invalid"
    render :new
  end
end

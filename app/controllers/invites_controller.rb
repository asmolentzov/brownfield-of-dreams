class InvitesController < ApplicationController
  
  def new
  end
  
  def create
    if presenter.invitee_info[:email]
      send_invite
    else
      invite_error
    end
  end
  
  private
  
  def presenter
    @_presenter ||= InvitePresenter.new(current_user, params[:github_handle])
  end
  
  def send_invite
    InviterMailer.invite(presenter.invitee_info, presenter.inviter_info).deliver_now
    flash[:notice] = 'Successfully sent invite!'
    redirect_to dashboard_path
  end
  
  def invite_error
    flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
    redirect_to dashboard_path
  end
end
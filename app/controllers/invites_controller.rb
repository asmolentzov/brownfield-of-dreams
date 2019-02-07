class InvitesController < ApplicationController
  
  def new
  end
  
  def create
    send_invite
    redirect_to dashboard_path
  end
  
  private
  
  def presenter
    @_presenter ||= InvitePresenter.new(current_user, params[:github_handle])
  end
  
  def send_invite
    if presenter.invitee_info[:email]
      InviterMailer.invite(presenter.invitee_info, presenter.inviter_info).deliver_now
      flash[:notice] = 'Successfully sent invite!'
    else
      flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
    end
  end
end
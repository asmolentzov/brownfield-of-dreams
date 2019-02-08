class TutorialsController < ApplicationController
  def show
    check_current_user
    if tutorial.videos.empty?
      tutorial.videos.new()
    end 
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
  
  private
  
  def tutorial
    @_tutorial ||= Tutorial.find(params[:id])
  end
  
  def check_current_user
    unless current_user
      four_oh_four if tutorial.classroom
    end
  end
end

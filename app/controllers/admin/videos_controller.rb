class Admin::VideosController < Admin::BaseController
  # Edit/update functionality is not built out yet. Commenting out code that is not being used, but leaving it for future iterations/expansion.
  # def edit
  #   @video = Video.find(params[:video_id])
  # end
  # 
  # def update
  #   video = Video.find(params[:id])
  #   video.update(video_params)
  # end

  def create
    begin
      create_video
    rescue # Sorry about this. We should get more specific instead of swallowing all errors.
      flash[:error] = "Unable to create video."
    end
    redirect_to edit_admin_tutorial_path(id: tutorial.id)
  end

  private
  
    def tutorial
      @_tutorial ||= Tutorial.find(params[:tutorial_id])
    end
    
    def create_video
      thumbnail = YouTube::Video.by_id(new_video_params[:video_id]).thumbnail
      video     = tutorial.videos.new(new_video_params.merge(thumbnail: thumbnail))
      video.save
      flash[:success] = "Successfully created video."
    end
    
    def new_video_params
      params.require(:video).permit(:title, :description, :video_id, :thumbnail)
    end
    
    # def video_params
    #   params.permit(:position)
    # end
end

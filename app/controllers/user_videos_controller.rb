class UserVideosController < ApplicationController
  def new
  end

  def create
    user_video = UserVideo.new(user_video_params)
    check_bookmark(user_video)
    redirect_back(fallback_location: root_path)
  end

  private

  def user_video_params
    params.permit(:user_id, :video_id)
  end

  def check_bookmark(user_video)
    if find_bookmark(user_video.video_id)
      flash[:error] = 'Already in your bookmarks'
    elsif user_video.save
      flash[:success] = 'Bookmark added to your dashboard!'
    end
  end
end

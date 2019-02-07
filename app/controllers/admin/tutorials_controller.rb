class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    @tutorial = Tutorial.new(create_tutorial_params)
    if @tutorial.save
      flash[:success]= "Successfully created tutorial."
      redirect_to tutorial_path(@tutorial.id)
    else
      flash[:error]= "Unable to create tutorial"
      render :new
    end 
  end

  def new
    @admin = User.find(current_user.id)
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def create_tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end
end

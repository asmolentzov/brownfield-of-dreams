class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    if new_tutorial.save
      create_tutorial
    else
      tutorial_error
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
  
  def new_tutorial
    @_tutorial ||= Tutorial.new(create_tutorial_params)
  end
  
  def create_tutorial
    flash[:success]= "Successfully created tutorial."
    redirect_to tutorial_path(new_tutorial.id)
  end
  
  def tutorial_error
    @tutorial = new_tutorial
    flash[:error]= "Unable to create tutorial"
    render :new
  end

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def create_tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end
end

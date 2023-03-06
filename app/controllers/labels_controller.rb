class LabelsController < ApplicationController
  before_action :admin_login_required
  
  def new
    if current_admin_user then
      @label = Label.new
    end
  end
  
  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to labels_path
    else
      render :new
    end
  end
  
  def show
    @labels = Label.all.page(params[:page])
  end
  
  def index
    @labels = Label.all.page(params[:page])
  end
  
  private

  def label_params
    params.require(:label).permit(:name )
  end
end

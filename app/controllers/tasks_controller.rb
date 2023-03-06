class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :login_user_only, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = current_user.tasks
    if params[:sort_expired]
      @tasks = @tasks.all.order(:due_date)
    elsif params[:sort_created]
      @tasks = @tasks.all.order(created_at: :desc)
    elsif params[:sort_priority]
      @tasks = @tasks.all.order(:priority)
    elsif params[:task].present?
      keyword = params[:task][:task_name]
      status = params[:task][:status]
      label = params[:task][:label_id]
      if keyword.present? && status.present?
        @tasks = @tasks.search_key_status(keyword, status)
      elsif keyword.present?
        @tasks = @tasks.search_key(keyword)
      elsif status.present?
        @tasks = @tasks.search_status(status)
      elsif label.present?
        @tasks = Label.find(label).tasks
      else
        @tasks = @tasks.all
      end

      
    else
      @tasks = @tasks.all
    end
    @tasks = @tasks.page(params[:page])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました！"
    else
      render :new
    end
  end
  
  def show
  end
  
  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
        render :edit
    end
  end
  
  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"
  end
  
  private

  def task_params
    params.require(:task).permit(:task_name, :task_detail, :due_date, :status, :priority, { label_ids: [] })
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def login_user_only
    redirect_to tasks_path unless @task.user_id == current_user.id 
  end
end

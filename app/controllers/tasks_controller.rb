class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    if params[:sort_expired]
      @tasks = Task.all.order(:due_date)
    elsif params[:sort_created]
      @tasks = Task.all.order(created_at: :desc)
    elsif params[:sort_priority]
      @tasks = Task.all.order(:priority)
    elsif params[:task].present?
      keyword = params[:task][:task_name]
      status = params[:task][:status]
      if keyword.present? && status.present?
        @tasks = Task.search_key_status(keyword, status)
      elsif keyword.present?
        @tasks = Task.search_key(keyword)
      elsif status.present?
        @tasks = Task.search_status(status)
      else
        render :task
      end
    else
      @tasks = Task.all
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
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
    params.require(:task).permit(:task_name, :task_detail, :due_date, :status, :priority)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
end

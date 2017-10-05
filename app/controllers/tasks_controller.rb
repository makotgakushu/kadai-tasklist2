class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task= current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Taskが正常に送信されました'
      redirect_to @task
    else 
      flash.now[:danger] ='Task が投稿されませんでした'
      render :new
    end
  end

  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'Taskが正常に更新されました'
      redirect_to @task
    else 
      flash.now[:danger] ='Task が更新されませんでした'
      render :new
    end
  end
  
  def destroy
    @task.destroy
    redirect_to root_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    redirect_to root_url if @task.user != current_user
  end
end

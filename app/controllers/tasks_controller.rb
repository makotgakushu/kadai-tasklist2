class TasksController < ApplicationController
  def index
    @tasks =Task.all
  end

  def show
  end

  def create
  end

  def edit
  end
end

class TasksController < ApplicationController
  def index
    @categories = Category.all
    @tasks = Task.all
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_url
    else
      render :index, status: :unprocessable_entity
    end
  end

  def toggle
    @task = Task.find(params[:id])
    @task.update(completed: !@task.completed)
    render json: { message: "Success", completed: @task.completed }
  end
  
  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_url}
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_url
  end
  
  
  private

  def task_params
    params.require(:task).permit(:description, :category_id)
  end
end




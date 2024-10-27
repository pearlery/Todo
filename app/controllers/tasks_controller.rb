class TasksController < ApplicationController
  def index
    @task = Task.new
    @tasks = Task.all # Fetch all tasks to display
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
    @task.update(completed: params[:completed])
  
    render json: { message: "Success" }
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
    params.require(:task).permit(:description)
  end
end




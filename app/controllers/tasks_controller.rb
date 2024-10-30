class TasksController < ApplicationController
  def index
    @categories = Category.all
    @tasks = Task.all
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append("tasks_list", partial: "tasks/task", locals: { task: @task })
        end
        format.html { redirect_to tasks_url }
      end
    else
      render :index, status: :unprocessable_entity
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
  
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@task)
      end
      format.html { redirect_to tasks_url }
    end
  end

  def toggle
    @task = Task.find(params[:id])
    @task.update(completed: !@task.completed)
  
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@task, partial: "tasks/task", locals: { task: @task })
      end
      format.html { redirect_to tasks_url }
    end
  end
  
  def edit
    @task = Task.find(params[:id])
    @categories = Category.all # Add this line to load categories
  end
  

  def update
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update(task_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@task, partial: "tasks/task", locals: { task: @task })
        end
        format.html { redirect_to tasks_url, notice: "Task updated successfully" }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@task, partial: "tasks/form", locals: { task: @task })
        end
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end
  
  
  private

  def task_params
    params.require(:task).permit(:description, :category_id)
  end
end




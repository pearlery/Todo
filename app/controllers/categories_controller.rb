class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "Category created successfully"
    else
      render :new
    end
  end
  def toggle
    @task = Task.find(params[:id])
    @task.update(completed: !@task.completed)
    render json: { message: "Success", completed: @task.completed }
  end
  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)

      redirect_to categories_path, notice: "Category updated successfully"

    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: "Category deleted successfully"
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end


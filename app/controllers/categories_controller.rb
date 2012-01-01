class CategoriesController < ApplicationController
  def index
    @categories = Category.all

    respond_to do |format|
      format.json { render json: @categories }
    end
  end
  
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.json { render json: @category.to_json(:include => :notes) }
    end
  end
end

class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @recipe = Recipe.all.order("created_at DESC")
  end

  def show
  end

  def new
    @recipe = current_user.recipes.build
    @categories = Category.all
    # @recipe = @category.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: "Yay! You have successfully created a new recipe"
    else
      @categories = Category.all

      render 'new'
    end
  end


  def edit
    @categories = Category.all

  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      @categories = Category.all

      render 'edit'
    end
  end

  def destroy
    @recipe.destroy
    @categories = Category.all
    redirect_to root_path, notice: "Recipe has been deleted!"
  end

  private
  #attributes we want to save to our model
  def recipe_params
    params.require(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy], categories_attributes: [:id, :title, :_destroy])
  end

  #create private method for finding the recipe by id
  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

end

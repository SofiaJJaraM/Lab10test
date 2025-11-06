class RecipesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all 
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    #@recipe = current_user.recipes.build(recipe_params)
    #if @recipe.save
    #  redirect_to recipe_path(@recipe)
    #else
    #  redirect_to new_recipe_path
    #end
    CreateRecipeJob.perform_later(recipe_params.to_h, current_user&.id)
    respond_to do |format|
      format.html { redirect_to recipes_path, notice: "Creación encolada. La receta se guardará cuando termine el proceso en segundo plano." }
      format.json { head :accepted }
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      redirect_to edit_recipe_path(@recipe)
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path
  end

  private

    def recipe_params
      params.require(:recipe).permit(:title, :cook_time, :difficulty, :instructions)
    end

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
end


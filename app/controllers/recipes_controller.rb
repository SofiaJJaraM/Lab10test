class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  load_and_authorize_resource

  # GET /recipes or /recipes.json
  def index
  end

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes or /recipes.json
  def create
    CreateRecipeJob.perform_later(recipe_params.to_h, current_user&.id)
    respond_to do |format|
      format.html { redirect_to recipes_path, notice: "Creación encolada. La receta se guardará cuando termine el proceso en segundo plano." }
      format.json { head :accepted }
    end
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: "Recipe was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.destroy!

    respond_to do |format|
      format.html { redirect_to recipes_path, notice: "Recipe was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def recipe_params
      params.require(:recipe).permit(:title, :cook_time, :difficulty, :instructions)
    end
end

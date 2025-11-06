class UpdateRecipeJob < ApplicationJob
  queue_as :default

  def perform(recipe_id)
    recipe = Recipe.find(recipe_id)

    puts "Procesando actualización de receta: #{recipe.name}"
  end
end

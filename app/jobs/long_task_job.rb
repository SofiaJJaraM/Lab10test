class LongTaskJob < ApplicationJob
  queue_as :default

  def perform(recipe_id, user_id = nil)
  Rails.logger.info "LongTaskJob started for recipe=#{recipe_id} user=#{user_id}"
  sleep 20

    if recipe = Recipe.find_by(id: recipe_id)
      recipe.touch
      Rails.logger.info "LongTaskJob completed for recipe=#{recipe_id}"
    else
      Rails.logger.warn "LongTaskJob: recipe #{recipe_id} not found"
    end
  end
end

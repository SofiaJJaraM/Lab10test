class CreateRecipeJob < ApplicationJob
  queue_as :default

  def perform(recipe_attrs, user_id = nil)
    Rails.logger.info "CreateRecipeJob: started for user=#{user_id} attrs=#{recipe_attrs.inspect}"
    sleep 10

    attrs = recipe_attrs.respond_to?(:to_hash) ? recipe_attrs.to_hash.dup : {}
    attrs = attrs.symbolize_keys

    instructions = attrs.delete(:instructions)

    recipe = Recipe.new(attrs)
    recipe.user_id = user_id if user_id.present?
    recipe.instructions = instructions if instructions.present?

    recipe.save!

    Rails.logger.info "CreateRecipeJob: created recipe id=#{recipe.id}"
  rescue => e
    Rails.logger.error "CreateRecipeJob: failed to create recipe - #{e.class}: #{e.message}\n#{e.backtrace.join("\n")}" unless Rails.env.test?
    raise
  end
end

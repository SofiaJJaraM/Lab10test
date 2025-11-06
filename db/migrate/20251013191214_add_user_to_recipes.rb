class AddUserToRecipes < ActiveRecord::Migration[8.0]
  def change
    # allow null for existing records; you can add a non-null constraint later
    add_reference :recipes, :user, null: true, foreign_key: true
  end
end

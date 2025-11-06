class EnforceUserOnRecipes < ActiveRecord::Migration[8.0]
  # Temporary lightweight models to avoid loading application code during migration
  class MigrationUser < ActiveRecord::Base
    self.table_name = 'users'
  end

  class MigrationRecipe < ActiveRecord::Base
    self.table_name = 'recipes'
  end

  def up
    say_with_time "Ensuring every recipe has an owner and making user_id NOT NULL" do
      # Ensure there's at least one user to assign as owner
      user = MigrationUser.first
      unless user
        user = MigrationUser.create!(email: 'seed@example.com', password: 'password123', password_confirmation: 'password123')
      end

      # Assign existing orphan recipes to that user
      MigrationRecipe.where(user_id: nil).update_all(user_id: user.id)

      # Enforce DB constraint
      change_column_null :recipes, :user_id, false
    end
  end

  def down
    say_with_time "Reverting user_id NOT NULL on recipes" do
      change_column_null :recipes, :user_id, true
    end
  end
end

class Recipe < ApplicationRecord
  belongs_to :user, optional: true
  has_rich_text :instructions
end
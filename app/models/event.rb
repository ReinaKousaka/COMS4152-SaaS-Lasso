class Event < ApplicationRecord
  # create bi-directional associations
  belongs_to :user

  def self.all_categories
    ["athletics", "academics", "career", "culture", "fun"]
  end

  def self.with_categories(categories, sort_by)
    
      where(category: categories.map(&:downcase)).order sort_by
    
  end

  
end

class Event < ActiveRecord::Base
  def self.all_categories
    return ["athletics", "academics", "career", "culture", "fun"]
  end 

  def self.with_categories(categories)
    if categories.nil? 
      return Event.all 
    end 
    return Event.where(category: categories)
  end 

  end
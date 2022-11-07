class Event < ActiveRecord::Base
  def self.all_categories
    ["athletics", "academics", "career", "culture", "fun"]
  end

  def self.with_categories(categories, sort_by)
    if categories.nil?
      all.order sort_by
    else
      where(category: categories.map(&:downcase)).order sort_by
    end
  end

  def self.with_sort(sort_by)
      all.order sort_by
  end



end

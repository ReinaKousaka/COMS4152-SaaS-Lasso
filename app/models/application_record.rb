# Represent associations between these models.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
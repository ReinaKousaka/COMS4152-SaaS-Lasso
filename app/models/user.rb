class User < ApplicationRecord
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :username, uniqueness: true
  validates :username, presence: true
  # create bi-directional associations
  # https://guides.rubyonrails.org/association_basics.html#bi-directional-associations
  has_many :events

end

class AddDescripitionToEvent < ActiveRecord::Migration
  def change
    add_column :events, :description, :text
  end
end

class CreateEvents < ActiveRecord::Migration
  def change
    create_table :event do |t|
      t.string :title
      t.string :organizer
      t.text :description
      t.datetime :date
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end
end

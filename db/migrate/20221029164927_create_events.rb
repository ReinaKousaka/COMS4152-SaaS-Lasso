class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :category
      t.string :organizer
      t.string :location

      t.references :users, null: false, foreign_key: true
    end
  end
end

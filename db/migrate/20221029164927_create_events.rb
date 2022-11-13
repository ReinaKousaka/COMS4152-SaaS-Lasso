class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :category
      t.string :organizer
      t.string :location

      t.references :user, null: false, foreign_key: true
      
      # https://stackoverflow.com/questions/17956204/foreign-key-in-rails-4
      # according to: https://edgeguides.rubyonrails.org/4_2_release_notes.html
      # rails4 doesn't support sqlite3 adapter
      # t.foreign_key :users
    end
  end
end

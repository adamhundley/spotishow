class CreateUserShows < ActiveRecord::Migration
  def change
    create_table :user_shows do |t|
      t.references :user, index: true, foreign_key: true
      t.references :show, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

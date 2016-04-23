class AddTitleToShows < ActiveRecord::Migration
  def change
    add_column :shows, :title, :string
  end
end

class ChangeNamesOnArtist < ActiveRecord::Migration
  def change
    enable_extension 'citext'
    change_column :artists, :name, :citext
  end
end

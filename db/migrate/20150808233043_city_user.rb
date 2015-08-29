class CityUser < ActiveRecord::Migration
  def change
     add_column :us, :city, :text
  end
end

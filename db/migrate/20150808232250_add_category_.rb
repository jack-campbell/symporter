class AddCategory < ActiveRecord::Migration
  def change
    add_column :products, :category, :text
  end
end

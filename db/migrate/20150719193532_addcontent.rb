class Addcontent < ActiveRecord::Migration
  def change
    add_column :products, :content, :text
  end
end

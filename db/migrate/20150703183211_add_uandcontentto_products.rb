class AddUandcontenttoProducts < ActiveRecord::Migration
  def change
    add_index :products, [:u_id]
  end
end

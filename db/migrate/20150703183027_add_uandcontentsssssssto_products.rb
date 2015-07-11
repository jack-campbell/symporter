class AddUandcontentssssssstoProducts < ActiveRecord::Migration
  def change
    add_column :products, :u_id, :integer
  end
end

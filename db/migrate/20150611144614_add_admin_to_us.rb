class AddAdminToUs < ActiveRecord::Migration
  def change
    add_column :us, :admin, :boolean, default: false
  end
end

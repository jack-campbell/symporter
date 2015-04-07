class AddIndexToUEmail < ActiveRecord::Migration
  def change
     add_index :us, :email, unique: true
  end
end

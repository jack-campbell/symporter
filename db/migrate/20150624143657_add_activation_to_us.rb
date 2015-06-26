class AddActivationToUs < ActiveRecord::Migration
  def change
      add_column :us, :activation_digest, :string
    add_column :us, :activated, :boolean, default: false
    add_column :us, :activated_at, :datetime
  end
end

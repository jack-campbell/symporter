class AddRememberDigestToUs < ActiveRecord::Migration
  def change
    add_column :us, :remember_digest, :string
  end
end

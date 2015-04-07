class AddPasswordDigestToUs < ActiveRecord::Migration
  def change
    add_column :us, :password_digest, :string
  end
end

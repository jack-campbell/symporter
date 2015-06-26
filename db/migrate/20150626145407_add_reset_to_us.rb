class AddResetToUs < ActiveRecord::Migration
  def change
    add_column :us, :reset_digest, :string
    add_column :us, :reset_sent_at, :datetime
  end
end

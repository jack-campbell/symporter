class AddInstitutionUser < ActiveRecord::Migration
  def change
     add_column :us, :institution, :text
  end
end

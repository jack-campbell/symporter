class CreateProds < ActiveRecord::Migration
  def change
    create_table :prods do |t|
      t.text :content
      t.references :u, index: true

      t.timestamps
    end
  end
end

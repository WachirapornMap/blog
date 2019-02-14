class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.text :detail
      t.integer :price
      t.references :type, foreign_key: true

      t.timestamps
    end
  end
end

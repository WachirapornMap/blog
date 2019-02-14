class Mg < ActiveRecord::Migration[5.2]
  def change
    #add_column :types, :detail, :text
    rename_column :types, :detail, :description
    #remove_column :types, :detail
  end
end

class AddIndexesToTables < ActiveRecord::Migration[8.0]
  def change
    add_index :visiteurs, :visiteur_id
    add_index :achats, :produit_id
  end
end

class CreateAchats < ActiveRecord::Migration[8.0]
  def change
    create_table :achats do |t|
      t.string :visiteur_id
      t.string :produit_id

      t.timestamps
    end
  end
end

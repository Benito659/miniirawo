class CreateVisiteur < ActiveRecord::Migration[8.0]
  def change
    create_table :visiteurs do |t|
      t.string :visiteur_id

      t.timestamps
    end
  end
end

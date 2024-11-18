class CreatePostsRessources < ActiveRecord::Migration[8.0]
  def change
    create_table :ressources do |t|
      t.string :titre
      t.text :description
      t.integer :prix
      t.boolean :typeArticle
      t.string :lien
      t.string :lienImage

      t.timestamps
    end
  end
end

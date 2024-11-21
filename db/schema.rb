# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_11_21_112811) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "achats", force: :cascade do |t|
    t.string "visiteur_id"
    t.integer "produit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["produit_id"], name: "index_achats_on_produit_id"
  end

  create_table "ressources", force: :cascade do |t|
    t.string "titre"
    t.text "description"
    t.integer "prix"
    t.boolean "typeArticle"
    t.string "lien"
    t.string "lienImage"
    t.string "categorie"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visiteurs", force: :cascade do |t|
    t.string "visiteur_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["visiteur_id"], name: "index_visiteurs_on_visiteur_id"
  end
end

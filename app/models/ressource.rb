class Ressource < ApplicationRecord
    has_many :achats, foreign_key: :produit_id
    has_many :visiteurs, through: :achats
end
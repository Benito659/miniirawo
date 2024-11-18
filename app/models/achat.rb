class Achat < ApplicationRecord
    belongs_to :visiteur, foreign_key: 'visiteur_id'
    belongs_to :ressource, foreign_key: 'produit_id'
end
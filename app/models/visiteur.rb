class Visiteur < ApplicationRecord
    has_many :achats, foreign_key: 'visiteur_id'
    has_many :ressources, through: :achats, source: :ressource
end

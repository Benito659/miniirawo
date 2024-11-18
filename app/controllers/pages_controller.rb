class PagesController<ApplicationController
    before_action :set_visitor_id
    
    def home 

        @ressources = Ressource.all
        
    end

    def produit
        @ressource_id = params[:id]
        @ressource = Ressource.find_by(id: @ressource_id)
    end

    def espacepersonnelle
      visiteur_id = session[:visiteur_id]
      if visiteur_id
        visiteur = Visiteur.find(visiteur_id)
        @ressources_achetees = visiteur.ressources
      else
        @ressources_achetees = []
      end
      
    end

    def admin
      @total_visiteurs = Visiteur.count
      @total_achats = Achat.count
      @total_visiteurs_avec_achats = Visiteur.joins(:achats).distinct.count
    end

    def achatproduit
        @ressource_id = params[:id]
        @ressource = Ressource.find_by(id: @ressource_id)
      
        if @ressource.nil?
          flash[:error] = "Produit non trouvé"
          redirect_to root_path and return
        end
      
        Achat.create(
          visiteur_id: cookies[:visitor_id], 
          produit_id: @ressource_id
        )
      
        @ressources = Ressource.where.not(id: @ressource_id)
      
        flash[:success] = "Achat enregistré avec succès"
      end
      

    private

    def set_visitor_id
      unless cookies.permanent[:visitor_id]
        visitor_id = SecureRandom.uuid
        Visiteur.create(visiteur_id: visitor_id)
        cookies.permanent[:visitor_id] = visitor_id
      end
    end
end

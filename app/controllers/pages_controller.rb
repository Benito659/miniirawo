class PagesController<ApplicationController
    before_action :set_visitor_id, :measure_backend_performance
    
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

        visiteur_id = request.remote_ip
        visiteur=Visiteur.find_by(visiteur_id: visiteur_id)
        achat=Achat.create(
          visiteur_id: visiteur.visiteur_id, 
          produit_id: @ressource_id
        )
        if achat.persisted?
          flash[:success] = "Achat enregistré avec succès"
        else
          flash[:error] = "Erreur lors de l'enregistrement de l'achat"
        end
      
        @ressources = Ressource.where.not(id: @ressource_id)
        flash[:success] = "Achat enregistré avec succès"
      end
      

    private

    def set_visitor_id
      ip_address = request.remote_ip
      unless Visiteur.exists?(visiteur_id: ip_address)
        Visiteur.create(visiteur_id: ip_address)
      end
    end

    def measure_backend_performance
      @start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end
  
    def append_info_to_payload(payload)
      super
      end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      payload[:backend_duration] = (end_time - @start_time) * 1000 # en millisecondes
    end
end

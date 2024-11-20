class PagesController<ApplicationController
  before_action :set_visitor_id, :measure_backend_performance
  
  def home 
    @ressources = Ressource.all

    visiteur_id = request.remote_ip
    visiteur=Visiteur.find_by(visiteur_id: visiteur_id)
    achats = visiteur.achats
    if achats.any?
      puts "Achats effectués par le visiteur #{visiteur.visiteur_id} :"
      achats.each do |achat|
        puts "Produit ID : #{achat.produit_id}, Créé à : #{achat.created_at}"
      end
    end
    ressource_ids_achetees = achats.pluck(:produit_id)
    @ressources = Ressource.where.not(id: ressource_ids_achetees )
  end

  def produit
      @ressource_id = params[:id]
      @ressource = Ressource.find_by(id: @ressource_id)
  end

  def espacepersonnelle
    visiteur_id = request.remote_ip
    visiteur=Visiteur.find_by(visiteur_id: visiteur_id)
    Rails.logger.debug { "Ressource : #{visiteur_id}" }
    if visiteur
      achats = visiteur.achats
      ressource_ids_achetees = achats.pluck(:produit_id)
      @ressources_achetees  = Ressource.where(id: ressource_ids_achetees )
      Rails.logger.debug { "Ressource : #{@ressources_achetees}" }
    else
      @ressources_achetees = []
    end
  end

  def admin
    @total_visiteurs = Visiteur.count
    @total_achats = Achat.count
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

    if visiteur.nil?
      flash[:error] = "Visiteur non trouvé"
      redirect_to root_path and return
    end

    achat=Achat.find_or_create_by(
      visiteur_id: visiteur.id, 
      produit_id: @ressource_id
    )
    if achat.persisted?
      Rails.logger.debug { "Succes de validation : #{achat.errors.full_messages}" }
      flash[:success] = "Achat enregistré avec succès"
    else
      Rails.logger.debug { "Erreurs de validation : #{achat.errors.full_messages}" }
      flash[:error] = "Erreur lors de l'enregistrement de l'achat"
    end

    achats = visiteur.achats
    ressource_ids_achetees = achats.pluck(:produit_id)
    @ressources = Ressource.where.not(id: ressource_ids_achetees)
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

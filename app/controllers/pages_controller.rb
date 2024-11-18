class PagesController<ApplicationController
    def home 

    end

    def produit
        # application_controller.rb
        before_action :set_visitor_id

        private

        def set_visitor_id
            cookies.permanent[:visitor_id] ||= SecureRandom.uuid
        end


    end

    def espacepersonnelle

    end

    def admin

    end
end
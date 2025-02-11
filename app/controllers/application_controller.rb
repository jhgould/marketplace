class ApplicationController < ActionController::Base

    def after_sign_in_path_for(resource)
        return admin_dashboard_path if current_admin_user
        
        if resource.onboarding_complete?
            root_path
            #will need to upadte onboarding_complete as
            #that is not method will not work right now
            # dashboard_path
        else
            onboarding_path("personal_info") # Start the onboarding process
        end
    end
end
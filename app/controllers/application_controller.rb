class ApplicationController < ActionController::Base

    def after_sign_in_path_for(resource)
        if resource.onboarding_complete?
            #will need to upadte onboarding_complete as
            #that is not method will not work right now
            # dashboard_path
        else
            onboarding_path(:personal_info) # Start the onboarding process
        end
    end
end

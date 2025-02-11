class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_dashboard_path
    else
      if resource.onboarding_complete?
        root_path
      else
        onboarding_path("personal_info") # Start the onboarding process
      end
    end
  end
end
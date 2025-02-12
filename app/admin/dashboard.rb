# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Statistics" do
          ul do
            li "Total Users: #{User.count}"
            li "Total Apartments: #{Apartment.count}"
            li "Pending Apartments: #{AdminPendingApartmentVerification.where(status: 'pending').count}"
          end
        end
      end
    end
  end 
end

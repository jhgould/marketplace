ActiveAdmin.register AdminPendingApartmentVerification do
  show do
    panel "Address Comparison" do
      div class: 'address-comparison' do
        div class: 'normalized-address' do
          h3 "Normalized Address"
          attributes_table_for resource do
            row :street_address
            row :city
            row :state
            row :zip_code
            row :country
          end
        end

        div class: 'submitted-address' do
          h3 "Submitted Address"
          attributes_table_for resource do
            row :submitted_street_address
            row :submitted_city
            row :submitted_state
            row :submitted_zip_code
            row :submitted_country
          end
        end
      end
    end

    panel "Additional Details" do
      attributes_table_for resource do
        row :status
        row :created_at
        row :updated_at
      end
    end
  end

  # Custom CSS for the layout
  index do
    div do
      style do
        raw """
          .address-comparison {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
          }
        """
      end
    end
  end
  
end

ActiveAdmin.register Apartment do
  
  form do |f|
      f.inputs do
        f.input :street_address
        f.input :city
        f.input :state
        f.input :zip_code
        f.input :country, as: :string
      end
      f.actions
    end


  controller do
    def create
      normalized_address = NormalizationService.new.normalize(permitted_params[:apartment])
      apartment_params = params.require(:apartment).permit(:street_address, :city, :state, :zip_code, :country, :full_address)
      @apartment = Apartment.new(apartment_params.merge(normalized_address))
      if @apartment.save
        redirect_to admin_apartment_path(@apartment), notice: "Apartment successfully created."
      else
        render :new
      end
    end 
  end 

  permit_params do
    permitted = [:street_address, :city, :state, :zip_code, :country, :full_address]
    permitted << :other if params[:action] == 'create' && current_admin_user
    permitted
  end
  
end

class ListingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @listing = Listing.new
    @listing.apartment_id = current_user.apartment.id
    @listing.user_id = current_user.id
    @listing.save(validate: false) # Don't validate yet
    redirect_to listing_step_path(@listing, Listing.form_steps.first)
  end
  
  def index 
    @listings = current_user.listings
  end

  def show 
    @listing = Listing.find(params[:id])
  end 

  def edit 
    @listing = Listing.find(params[:id])  
    @listing.save(validate: false) # Don't validate yet
    redirect_to listing_step_path(@listing, Listing.form_steps[1])
  end 

  def destroy
    @listing = Listing.find(params[:id])
    if @listing.destroy
      flash[:notice] = "Listing has been deleted"
      redirect_to listings_path
    else
      flash[:alert] = "Unable to delete listing"
      redirect_to listing_path(@listing)
    end
  end

end
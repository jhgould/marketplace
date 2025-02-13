class ListingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @listing = Listing.new
    @listing.apartment_id = current_user.apartment.id
    @listing.user_id = current_user.id
    @listing.save(validate: false) # Don't validate yet
    redirect_to listing_step_path(@listing, Listing.form_steps.first)
  end

end
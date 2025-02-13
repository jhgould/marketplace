class Listings::StepsController < ApplicationController
  include Wicked::Wizard

  before_action :set_listing

  steps *Listing.form_steps

  def show
    render_wizard
  end

  def update
    if @listing.update(listing_params(step))
      if step == Listing.form_steps.last
        redirect_to finish_wizard_path and return
      end 
      render_wizard @listing
    else
      render step
    end
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def listing_params(step)
    case step
    when "listing_type"
      params.require("listing").permit(:type, :form_step).merge(form_step: step)
    else
      model_name = params.keys.find { |key| key.include?("_listing") } || "listing"
      params.require(model_name).permit(permitted_attributes_for(@listing.type, step), :form_step).merge(form_step: step)
    end
  end

  def permitted_attributes_for(listing_type, step)
    case listing_type
    when "ProductListing"
      product_listing_params(step)
    when "ServiceListing"
      puts "call service listing"
      # service_listing_params(step)
    when "RentalListing"
      # rental_listing_params(step)
      puts "call rental listing"
    else
      raise "Unknown listing type"
    end
  end

  def product_listing_params(step)
    case step
    when "details"
      [:title, :description, :price]
    when "categories"
      [:category_ids]
    when "images"
      [images: []]
    end
  end

  def finish_wizard_path
    user_dashboard_path
  end 
  
end

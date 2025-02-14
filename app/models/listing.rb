class Listing < ApplicationRecord
  belongs_to :apartment
  belongs_to :user

  has_many :listing_categories, dependent: :destroy
  has_many :categories, through: :listing_categories

  has_many_attached :images

  cattr_accessor :form_steps do
    %w[listing_type details categories images]
  end

  attr_accessor :form_step

  def required_for_step?(step)
    return true if form_step.nil?
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end

  # Validations per step
  with_options if: -> { required_for_step?(:listing_type) } do |step|
    step.validates :type, presence: true
  end

  with_options if: -> { required_for_step?(:details) } do |step|
    step.validates :title, presence: true
    step.validates :description, presence: true
    step.validates :price, presence: true
  end

  with_options if: -> { required_for_step?(:categories) } do |step|
    step.validates :categories, presence: true
  end

  with_options if: -> { required_for_step?(:images) } do |step|
    step.validates :images, presence: true
  end

  def self.ransackable_associations(auth_object = nil)
    ["apartment", "categories", "images_attachments", "images_blobs", "listing_categories", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["apartment_id", "created_at", "currency", "description", "id", "id_value", "metadata", "price", "status", "title", "type", "updated_at", "user_id"]
  end
end
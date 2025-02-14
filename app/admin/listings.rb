ActiveAdmin.register Listing do
  permit_params :title, :description, :price, :category_ids, :images
end

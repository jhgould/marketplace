class ApartmentSearchService 
    def search(address)
        Apartment.find_by(
            street_address: address[:street_address],
            city: address[:city],
            state: address[:state],
            zip_code: address[:zip_code],
            country: address[:country]
            )
    end 
end 
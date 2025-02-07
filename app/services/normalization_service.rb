class NormalizationService 
  def normalize(address)
    formatted_address = format_address(address)
    result = Geocoder.search(formatted_address).first
    return unless result

    build_normalized_address(result)
  end

  private

  # Formats the input address into a single string for geocoding
  def format_address(address)
    [
      address[:street_address],
      address[:city],
      address[:state],
      address[:country],
      address[:postal_code], 
    ].compact.join(', ')
  end

  # Builds a normalized address hash from the geocoded result
  def build_normalized_address(result)
     address_data = result.data["address"] || {}

     {
      "street_address" => "#{address_data['house_number']} #{address_data['road']}".strip, 
      "city" => address_data["city"], 
      "state" => address_data["state"], 
      "country" => address_data["country"], 
      "zip_code" => address_data["postcode"],
      "full_address" => result.data["display_name"]
     }
  end

  # Finds a component by type in the geocoded result
  def find_component(result, type)
    component = result.data['address_components'].find { |c| c['types'].include?(type) }
    component ? component['long_name'] : nil
  end
end 
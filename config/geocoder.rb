  Geocoder.configure(
    lookup: :google, # or :nominatim or any other supported service
    api_key: Rails.application.credentials.dig(:google, :geocoder, :api_key),
    timeout: 5,
    units: :km
  )
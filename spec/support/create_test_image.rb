require 'rmagick'

image = Magick::Image.new(100, 100) { self.background_color = 'blue' }
image.write(Rails.root.join("spec/fixtures/files/test_image.jpg"))

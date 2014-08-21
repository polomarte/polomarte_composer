class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # https://github.com/jnicklas/carrierwave/wiki/How-to%3A-Specify-the-image-quality
  process quality: 90

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    file_path = [
      'fallbacks',
      [model.class.to_s.underscore, mounted_as, "#{version_name}.png"].compact.join('_')
    ].join '/'

    ActionController::Base.helpers.image_path(file_path)
  end

  # version :fullscreen do
  #   process resize_to_fill: [1920, 1080]
  # end

  # version :blur do
  #   process :gaussian_blur
  # end

  # version :slide_blur do
  #   process resize_to_fill: [890, 445]
  #   process :gaussian_blur
  # end

protected

  def gaussian_blur
    manipulate! do |img|
      # docs at http://www.imagemagick.org/Usage/blur/#blur_args
      img.blur("0x35")
      img = yield(img) if block_given?
      img
    end
  end
end

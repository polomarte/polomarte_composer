CarrierWave.configure do |config|
  if Rails.env.production? || Rails.env.staging?
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                'sa-east-1',
      path_style:            true
    }
    config.fog_directory = ENV['FOG_DIRECTORY']
    config.asset_host    = "http://#{ENV['FOG_DIRECTORY']}.s3.amazonaws.com"
    config.storage       = :fog
  else
    config.enable_processing = false if Rails.env.test?
    config.storage = :file
  end
end

# https://github.com/jnicklas/carrierwave/wiki/How-to%3A-Specify-the-image-quality
module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end

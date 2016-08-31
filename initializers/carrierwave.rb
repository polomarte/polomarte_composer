CarrierWave.configure do |config|
  if Rails.env.production? || Rails.env.staging?
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                'us-east-1',
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

module CarrierWave
  module MiniMagick
    # https://coderwall.com/p/ryzmaa/use-imagemagick-to-create-optimised-and-progressive-jpgs
    def optimize_jpeg
      manipulate! do |img|
        return img unless img.mime_type.match /image\/jpeg/
        img.strip
        img.combine_options do |c|
            c.quality '80'
            c.depth '8'
            c.interlace 'plane'
        end
        img
      end
    end
  end
end

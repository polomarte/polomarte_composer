module ComponentsBuilder
  def up_components!
    if ENV['COMPONENT'].present?
      puts "Creating #{ENV['COMPONENT']}..."
      public_send "build_#{ENV['COMPONENT'].gsub(':', '_')}!"
    else
      self.class.public_instance_methods.grep(/^build_/).each do |method|
        puts "Running #{method}..."
        public_send method
      end
    end
  end

  def destroy_multiple_components! components
    try "destroy_#{components.gsub(':', '_')}!"
  end

  # def build_xxxxxx!
  # end
end

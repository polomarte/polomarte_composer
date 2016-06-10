require_relative 'components_builder'

class Components < ActiveRecord::Migration
  include ComponentsBuilder

  # Creating a single component:
  # rake data:migrate:redo VERSION=XXX COMPONENT=X:Y:Z
  def up
    up_components!
  end

  def down
    if ENV['COMPONENT'].present?
      puts "Destroying #{ENV['COMPONENT']}..."
      Component[ENV['COMPONENT']].try(:destroy!) || destroy_multiple_components!(ENV['COMPONENT'])
    else
      puts "Destroying all components..."
      Component.destroy_all
    end
  end

private

  def create_html_paragraphs count
    Faker::Lorem.paragraphs(count).map{|p| "<p>#{p}</p>"}.join('')
  end

  def open_file path
    File.open("#{Rails.root}/db/data/files/#{path}")
  end

  def build_image kind, path
    Image.new(kind: kind, file: open_file(path))
  end

  def build_document path
    Document.new(file: open_file(path))
  end

  def load_yaml path
    YAML.load_file "#{Rails.root}/db/data/files/#{path}"
  end
end

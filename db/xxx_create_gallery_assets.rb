class CreateGalleryAssets < ActiveRecord::Migration
  def change
    create_table :gallery_assets do |t|
      t.integer :gallery_id
      t.integer :kind
      t.string :title
      t.text :description
      t.boolean :active
      t.string :file
      t.string :image
      t.string :video_code
      t.integer :position
    end
  end
end

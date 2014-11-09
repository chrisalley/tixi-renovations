class DropPhotos < ActiveRecord::Migration
  def up
    drop_table :photos
  end

  def down
    create_table :photos do |t|
      t.string :photo
      t.text :description
      t.boolean :published, default: false

      t.timestamps
    end
  end
end

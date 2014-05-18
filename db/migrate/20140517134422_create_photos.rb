class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo
      t.text :description
      t.boolean :published, default: false

      t.timestamps
    end
  end
end

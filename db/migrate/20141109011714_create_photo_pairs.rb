class CreatePhotoPairs < ActiveRecord::Migration
  def change
    create_table :photo_pairs do |t|
      t.string :before_photo
      t.string :after_photo
      t.text :caption
      t.boolean :published, default: false

      t.timestamps
    end
  end
end

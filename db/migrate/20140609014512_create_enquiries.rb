class CreateEnquiries < ActiveRecord::Migration
  def change
    create_table :enquiries do |t|
      t.text :type_of_work
      t.string :first_name
      t.string :last_name
      t.string :telephone
      t.string :email_address
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :postal_code

      t.timestamps
    end
  end
end

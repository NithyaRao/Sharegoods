class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address1, :null => false
      t.string :address2
      t.string :city, :null => false
      t.string :state, :null => false, :limit => 2
      t.string :zip, :null => false
      t.string :home_phone
      t.string :cell_phone
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

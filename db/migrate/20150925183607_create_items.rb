class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :category_id
      t.string :name
      t.text :description
      t.integer :owner_id
      t.string :avatar
      t.integer :requestor_id
      t.datetime :available_at
      t.datetime :requesting_at
      t.datetime :returning_at
      t.text :comment
      t.boolean :available
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end

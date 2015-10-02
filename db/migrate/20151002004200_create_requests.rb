class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :requestor_id
      t.datetime :requesting_at
      t.datetime :returning_at
      t.text :description

      t.timestamps null: false
    end
  end
end

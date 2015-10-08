class CreateWishitems < ActiveRecord::Migration
  def change
    create_table :wishitems do |t|

      t.references :category, index: true
      t.string   "name",                            null:false
      t.text     "description"
      t.integer  "requestor_id"
      t.datetime "requesting_at"
      t.timestamps null: false
    end
  end
end

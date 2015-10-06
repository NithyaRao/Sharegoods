class AddacceptedToRequest < ActiveRecord::Migration
  def change
     add_column :requests, :accepted, :boolean, default: false
  end
end

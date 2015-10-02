class ChangeDataTypeForFieldname < ActiveRecord::Migration
  def change
      change_column :groups, :owner_id, :integer
  end
end

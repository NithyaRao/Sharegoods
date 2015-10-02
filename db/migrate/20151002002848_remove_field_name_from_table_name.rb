class RemoveFieldNameFromTableName < ActiveRecord::Migration
  def change
    remove_column :items, :requestor_id, :integer
    remove_column :items, :requesting_at, :datetime
    remove_column :items, :returning_at, :datetime

  end
end

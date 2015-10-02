class RemovereturningAtFromTableName < ActiveRecord::Migration
  def change
    remove_column :items, :returning_at, :datetime
  end
end

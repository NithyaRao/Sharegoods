class RenameOwnerinGrouptoOwnerId < ActiveRecord::Migration
  def change
    rename_column :groups, :owner, :owner_id
  end
end

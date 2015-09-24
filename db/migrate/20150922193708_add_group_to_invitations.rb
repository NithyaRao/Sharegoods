class AddGroupToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :group_id, :integer
    add_index :invitations, :group_id
  end
end

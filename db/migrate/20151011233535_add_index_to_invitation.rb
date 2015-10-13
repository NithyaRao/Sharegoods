class AddIndexToInvitation < ActiveRecord::Migration
  def change
     add_index :invitations, :recipient_email, unique: true
  end
end

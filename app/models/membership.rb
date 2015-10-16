class Membership < ActiveRecord::Base
#validates_presence_of :invitation_id, :message => 'is required'
#validates_uniqueness_of :invitation_id
belongs_to :user
belongs_to :group
has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
belongs_to :invitation
has_many :share_items, :class_name => 'Item', :foreign_key => 'owner_id'
belongs_to :item
has_many :requests
has_many :wishitems

def invitation_token
  invitation.token if invitation
end

def invitation_token=(token)
  self.invitation = Invitation.find_by_token(token)
end

end

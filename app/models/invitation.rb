class Invitation < ActiveRecord::Base
belongs_to :sender, :class_name => 'Membership'
has_one :recipient, :class_name => 'Membership'
has_one :group

validates_presence_of :recipient_email, uniqueness: {message: "Invite already sent"}
validates_presence_of :group_id
validate :recipient_is_not_registered

before_create :generate_token
default_scope { order('updated_at DESC') }

private

def recipient_is_not_registered
  errors.add :recipient_email, 'is already registered' if User.find_by_email(:recipient_email)
end

def generate_token
  self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
end

end

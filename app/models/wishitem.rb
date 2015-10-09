class Wishitem < ActiveRecord::Base
  has_one :requestor, class_name: 'Membership'
  belongs_to :category
  default_scope { order('requesting_at DESC') }

  def requestor_name
    User.find(Membership.find(self.requestor_id).user_id).name if self.requestor_id
  end

end

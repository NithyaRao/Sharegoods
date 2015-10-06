class Request < ActiveRecord::Base
  belongs_to :item
  has_one :requestor, class_name: 'Membership'
  validates_dates :requesting_at, from: Date.today , to: Date.today+365.days, allow_nil: false
  validates_dates :returning_at, from: :requesting_at , to: Date.today+365.days, allow_nil: false
  
 def requestor_name
       User.find(Membership.find(self.requestor_id).user_id).name if self.requestor_id
   end

end

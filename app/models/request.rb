class Request < ActiveRecord::Base
  belongs_to :item
  has_one :requestor, :class_name => 'Membership'
 
end

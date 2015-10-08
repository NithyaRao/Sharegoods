class Wishitem < ActiveRecord::Base
  has_one :requestor, class_name: 'Membership'
  belongs_to :category
  
end

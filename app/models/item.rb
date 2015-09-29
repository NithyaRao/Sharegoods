class Item < ActiveRecord::Base
   belongs_to :category
   belongs_to :owner, :class_name => 'Membership'
   has_one :requestor, :class_name => 'Membership'
 
   before_save :get_category_id
  
   def get_category_id
   end
 
   def categorized
      self.category_id 
   end
end

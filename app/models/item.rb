class Item < ActiveRecord::Base
   belongs_to :category
   belongs_to :owner, :class_name => 'Membership'
   has_one :requestor, :class_name => 'Membership'
 
  # before_save :get_category_id
  
  # def get_category_id
  #     Category.find(self.category
  # end
 
   
   def contact_name 
       User.find(Membership.find(self.owner_id).user_id).name
   end

   def requestor_name
       User.find(Membership.find(self.requestor_id).user_id).name if self.requestor_id
   end
end

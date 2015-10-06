class Item < ActiveRecord::Base
   belongs_to :category
   belongs_to :owner, :class_name => 'Membership'
     has_many :requests
   
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

   def item_name
       self.name
   end

   def item_description
        self.description
   end
end

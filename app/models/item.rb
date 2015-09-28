class Item < ActiveRecord::Base
   belongs_to :category
   belongs_to :membership
   before_save :get_category_id

   def get_category_id
   end
end

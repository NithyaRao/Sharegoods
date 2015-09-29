class Group < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships

  after_create :owner_be_group_member

  def owner_be_group_member
      self.memberships.create(user_id: self.owner, groupowner: true)
  end
end

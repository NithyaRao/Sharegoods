class Group < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  validates :name, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 20 }, presence: true
  validates :owner_id, presence: true
  after_create :owner_be_group_member


  def owner_be_group_member
      self.memberships.create(user_id: self.owner_id, groupowner: true)
  end
end

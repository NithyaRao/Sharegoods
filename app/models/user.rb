class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :memberships, :dependent => :destroy
  has_many :groups, :through => :memberships

  after_create  :check_invitation

  def check_invitation
     # check if the user got an invitation to a group , if yes then 
     # creates a membership record and deletes the invitation.
     # debugger
     @invitation = Invitation.find_by_recipient_email(self.email) 
     if @invitation 
        #create membership record 
        self.memberships.create(group_id: @invitation.group_id, invitation_id: @invitation.id )
        @invitation.delete
     end
  end 
end

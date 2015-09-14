require 'rails_helper'

describe "User Sign In and Sign out ", js: true do
   
   describe "Sign into blocmetrics" do
    describe "should allow registered user to sign in" do
      let!(:user) { FactoryGirl.create(:user) }
      before do  
          sign_in(user)
        #  save_and_open_page
     end 
     it "sucessful,redirects to the Index of Registered application" do  
    # STDIN.getc   
      wait 1 do
      expect(current_path).to eq root_path   
      end  
     end

     it "does the top navigation change to indicate you are signed in?" do 
     # STDIN.getc
     # save_and_open_page
      wait 1 do 
      expect(current_path).to eq root_path
      end
      expect(page).not_to have_content( "Sign In or Sign Up")
      expect(page).to have_content( "Sign out")
     end
   end 
  describe "should not allow unregistered user to sign in" do
    it "should not allow an unregistered user to sign in" do
      visit new_user_session_path
      fill_in "Email", :with => "notarealuser@example.com"
      fill_in "Password", :with => "fakepassword"
      click_button "Sign in"
      expect(page).to have_content("Sign In or Sign Up")
      expect(page).to have_content("Invalid email or password")
    end
  end  
 end

  describe "Sign out of blocmark " do
      let!(:user) { FactoryGirl.create(:user) }
      before do  
         sign_in(user)
        # save_and_open_page
     end 

     it "sign out successful" do
       within '.user-info' do

         click_link 'Sign out'
       end
      expect(page).to have_content( "Sign In or Sign Up")
      expect(page).not_to have_content( "Sign out")

    end
 end

 describe "Attempt to reset password " do
     let!(:user) { FactoryGirl.create(:user) }
    # around(:each) { ActionMailer::Base.deliveries.clear }  
      
     describe "reset password through forgot password link", type: :mailer  do
      
       before do
        visit new_user_session_path
        fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password
       end
        it "displays forgot your password" do
         # reset_mailer

         click_link "Forgot your password?"
         fill_in "Email", :with => user.email
        # save_and_open_page
         click_button "Send me reset password instructions"
         #save_and_open_page
         wait 1 do
         expect(last_email.to).to eq [user.email]
         end
      end  
     end 
 end
end
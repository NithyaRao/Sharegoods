FactoryGirl.define do
   factory :user do
     name "Douglas Adams"
     sequence(:email, 100) { |n| "person#{n}@example.com" }
     password "helloworld"
     password_confirmation "helloworld"
     confirmed_at Time.now
   end

    factory :new_user, :class => 'User'  do
     name "Adam Smith"
     sequence(:email, 100) { |n| "personnew#{n}@example.com" }
     password "helloworld"
     password_confirmation "helloworld"
   end

 end
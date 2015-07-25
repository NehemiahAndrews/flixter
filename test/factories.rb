FactoryGirl.define do  

  factory :user do
    sequence :email do |n|
      "nehemiah.andrews#{n}@gmail.com"
    end
    password "12345!!!54321"
    password_confirmation "12345!!!54321"
  end

  factory :course do
    title "WebDev 101"
    description "Developing 101 web things"
    cost "350.00"
    association :user
  end

end
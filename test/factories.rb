FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "nehemiah.andrews#{n}@gmail.com"
    end
    password "12345!!!54321"
    password_confirmation "12345!!!54321"
  end
end
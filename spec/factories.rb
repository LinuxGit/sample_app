FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Daniel #{n}" }
    sequence(:email) { |n| "goface#{n}@gmail.com" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
end

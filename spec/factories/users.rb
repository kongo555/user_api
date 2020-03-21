FactoryBot.define do
  factory :user do
    name { 'Name' }
    sequence(:email) { |n| "user#{n}@email.com" }
    date_of_birth  { 21.years.ago }
  end
end

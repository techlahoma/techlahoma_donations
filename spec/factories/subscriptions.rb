FactoryGirl.define do
  factory :subscription do
    stripe_subscription_id 'sub_42'
    email 'test@person.com'
    stripe_plan_id 'membership-2017-64'
    token_id 'xyz'
  end
end

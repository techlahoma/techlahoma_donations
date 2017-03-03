FactoryGirl.define do
  factory :donation do
    name "test person"
    email "test@person.com"
    amount 1000
    token_id 'xyz'
  end
end

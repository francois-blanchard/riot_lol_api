FactoryGirl.define do
  factory :client, class: RiotLolApi::Client do
    region 'euw'
    initialize_with { new(region: region) }
  end
end

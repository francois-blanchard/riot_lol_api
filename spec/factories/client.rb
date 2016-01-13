FactoryGirl.define do
  factory :client, class: RiotLolApi::Client do
    region 'euw'
    api_key RiotLolApi::FAKETOKEN
    initialize_with { new(region: region, api_key: api_key) }
  end
end

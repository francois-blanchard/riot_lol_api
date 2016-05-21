require 'spec_helper'

describe RiotLolApi::Support::Region do
  it 'euw region match with EUW1 platform' do
    region = 'euw'
    expect(RiotLolApi::Support::Region.new(region).platform).to eq 'EUW1'
  end
end

FactoryGirl.define do
	factory :page, :class => RiotLolApi::Model::Page do
		id 37482369
		name "support"
		current false
		masteries nil
		slots nil
		initialize_with { new(:id => id, :name => name, :current => current, :masteries => masteries, :slots => slots) }
	end
end

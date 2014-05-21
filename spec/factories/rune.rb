FactoryGirl.define do
	factory :rune, :class => RiotLolApi::Model::Rune do
		id_rune 37482369
		name "support"
		current false
		slots nil 
		initialize_with { new(:id_rune => id_rune, :name => name, :current => current, :slots => slots) }
	end
end
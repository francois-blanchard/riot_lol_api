FactoryGirl.define do
	factory :mastery, :class => RiotLolApi::Model::Mastery do
		id_mastery 37482369
		name "support"
		current false
		talents nil 
		initialize_with { new(:id_mastery => id_mastery, :name => name, :current => current, :talents => talents) }
	end
end
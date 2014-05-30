FactoryGirl.define do
	factory :champion, :class => RiotLolApi::Model::Champion do
		id 412
		key "Thresh"
		name "Thresh"
		title "Garde aux chaînes" 
		initialize_with { new(:id => id, :key => key, :name => name, :title => title) }
	end
end
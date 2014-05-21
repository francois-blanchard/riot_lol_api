FactoryGirl.define do
	factory :summoner, :class => RiotLolApi::Model::Summoner do
		id_summoner 20639710
		name "PacoLoco"
		profile_icon_id 8
		summoner_level 30
		revision_date_str ''
		revision_date 1398345588000
		region "euw"
		initialize_with { new(:id_summoner => id_summoner, :name => name, :profile_icon_id => profile_icon_id, :summoner_level => summoner_level, :revision_date_str => revision_date_str, :revision_date => revision_date, :region => region) }
	end
end
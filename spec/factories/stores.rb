FactoryGirl.define do
  factory :store do
    name {FFaker::Company.name}
	address {FFaker::Address.street_address}
	description {FFaker::Lorem.sentences}
	open_time  [["foo"], ["bar"]]
  end

end

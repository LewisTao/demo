FactoryGirl.define do
  factory :store do
    name {FFaker::Company.name}
	address {FFaker::Address.street_address}
	description {FFaker::HipsterIpsum.paragraph}
	open_time  ""
  end

end

FactoryGirl.define do
  factory :campaign do
    title { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
    user #rails known the user has relationship with campaign and make the call factory
  end
end
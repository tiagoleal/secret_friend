FactoryBot.define do
  factory :member do
    name { FFaker::Lorem.word }
    email { FFaker::Internet.email }
    campaign #rails known the campaign has relationship with campaign and make the call factory
  end
end
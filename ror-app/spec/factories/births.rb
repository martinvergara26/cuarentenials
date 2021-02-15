FactoryBot.define do
    factory :birth do 
        name { Faker::Name.first_name + ' ' + Faker::Name.last_name}
        estimated_date { Faker::Date.forward(days: 50) }
        user { FactoryBot.create(:user) }
    end
end
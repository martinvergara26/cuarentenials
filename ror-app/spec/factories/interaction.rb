FactoryBot.define do
    factory :interaction do
        name { "Interacccction" }
        phase { FactoryBot.create(:phase) }
    end
end
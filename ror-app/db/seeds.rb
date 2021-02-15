require 'factory_bot'
require 'faker'

FactoryBot.find_definitions

@phase_1 = Phase.create(name: 'Fase 1')
@phase_2 = Phase.create(name: 'Fase 2')
@phase_3 = Phase.create(name: 'Fase 3')
@phase_4 = Phase.create(name: 'Fase 4')

5.times { 
    @user = FactoryBot.create(:user, password: '123456')
    FactoryBot.create(:birth, user: @user, phase: @phase_1) 
}
5.times { 
    @user = FactoryBot.create(:user, password: '123456')
    FactoryBot.create(:birth, user: @user, phase: @phase_2) 
}
5.times { 
    @user = FactoryBot.create(:user, password: '123456')
    FactoryBot.create(:birth, user: @user, phase: @phase_3) 
}
5.times { 
    @user = FactoryBot.create(:user, password: '123456')
    FactoryBot.create(:birth, user: @user, phase: @phase_4) 
}


@user_pmc = User.create(email: 'pmc2@gmail.com', password: '123456', is_pmc: true)

@phase_prueba = Phase.create(name: 'Fase prueba 2')

@birth_carlos = Birth.create(name: 'Carlos', phase: @phase_prueba, user: @user_pmc, estimated_date: Faker::Date.forward(days: 50))

@gift = Gift.create(name: 'Alfajor', phase: @phase_prueba)

@user_vds = User.create(email: 'vds2@gmail.com', password: '123456', is_pmc: false)

@given_gift = GivenGift.create(user: @user_vds, gift: @gift, birth: @birth_carlos)
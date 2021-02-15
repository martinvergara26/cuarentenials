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

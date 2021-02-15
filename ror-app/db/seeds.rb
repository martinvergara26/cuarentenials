require 'factory_bot'
require 'faker'

FactoryBot.find_definitions

@phase_1 = Phase.create(name: 'Fase 1')
@phase_2 = Phase.create(name: 'Fase 2')
@phase_3 = Phase.create(name: 'Fase 3')
@phase_4 = Phase.create(name: 'Fase 4')

10.times { FactoryBot.create(:birth, phase: @phase_1) }
10.times { FactoryBot.create(:birth, phase: @phase_2) }
10.times { FactoryBot.create(:birth, phase: @phase_3) }
10.times { FactoryBot.create(:birth, phase: @phase_4) }

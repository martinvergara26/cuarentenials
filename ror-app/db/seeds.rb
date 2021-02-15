require 'factory_bot'
require 'faker'

FactoryBot.find_definitions

def create_phases
    @phase_1 = Phase.create(name: 'Fase 1')
    @phase_2 = Phase.create(name: 'Fase 2')
    @phase_3 = Phase.create(name: 'Fase 3')
    @phase_4 = Phase.create(name: 'Fase 4')
end

def create_gifts
    gifts_phase_1 = ["Una alfombra", "Una sillita de comer", "Un portabebé", "Una suscripción a Disney+"]
    gifts_phase_2 = gifts_phase_1 + ["Lego for Babies", "Plastilina Acrilex", "Muñeco Centeniial"]
    gifts_phase_3 = gifts_phase_2 + ["Un cochecito", "Juguete burbujero", "Gift Card de Cheeky", "Sombrero Cool"]
    gifts_phase_4 = gifts_phase_3 + ["Una visita a una granja", "Vacaiones en Mar del Tuyú", "Obra de teatro al aire libre"]

    gifts_phase_1.each { |gift|
        Gift.create(name: gift, phase: @phase_1) 
    }

    gifts_phase_2.each { |gift|
        Gift.create(name: gift, phase: @phase_2) 
    }

    gifts_phase_3.each { |gift|
        Gift.create(name: gift, phase: @phase_3) 
    }

    gifts_phase_4.each { |gift|
        Gift.create(name: gift, phase: @phase_4) 
    }
end

def create_parents_and_births
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
end

create_phases
create_gifts
create_parents_and_births
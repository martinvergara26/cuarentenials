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

def create_interactions
  # Interacciones Fase 1
  @videollamada = Interaction.create(
      name: 'Videollamada de hasta 5 personas',
      allowed_attendees: 5,
      allowed_times_a_day: 24,
      csv_not_allowed_days: '',
      phase: @phase_1
  )

  # Interacciones Fase 2
  Interaction.create(@videollamada.attributes.merge({phase: @phase_2, id: nil}))
  @visita_presencial = Interaction.create(
      name: 'Visita presencial (del otro lado del vidrio)',
      allowed_attendees: 1,
      allowed_times_a_day: 24,
      csv_not_allowed_days: '',
      phase: @phase_2
  )

  # Interacciones Fase 3
  Interaction.create(@videollamada.attributes.merge({phase: @phase_3, id: nil}))
  Interaction.create(@visita_presencial.attributes.merge({phase: @phase_3, id: nil}))
  @vuelta_a_la_plaza = Interaction.create(
      name: 'Vuelta a la plaza',
      allowed_attendees: 1,
      allowed_times_a_day: 24,
      csv_not_allowed_days: '1,2,3,4,5',
      phase: @phase_3
  )

  # Interacciones Fase 4
  Interaction.create(@videollamada.attributes.merge({phase: @phase_4, id: nil}))
  Interaction.create(@visita_presencial.attributes.merge({phase: @phase_4, id: nil}))
  Interaction.create(@vuelta_a_la_plaza.attributes.merge({phase: @phase_4, id: nil}))
  @reunion_diaria = Interaction.create(
      name: 'Reunión diaria en espacios abiertos. Hasta 10 personas.',
      allowed_attendees: 10,
      allowed_times_a_day: 1,
      csv_not_allowed_days: '',
      phase: @phase_4
  )
end

create_phases
create_gifts
create_parents_and_births
create_interactions
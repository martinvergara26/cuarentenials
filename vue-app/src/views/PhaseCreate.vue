<template>
  <div class="home">
    <h4>Creá tu propia fase</h4>
    
    <form @submit.prevent="createPhase">
      <label for="name">
        Nombre de fase
      </label>
      <input v-model="name" type="name" name="name" value>

      <div>
        <h4>Interacciones</h4>

        <div class="interaction" v-for="(interaction, index) in interactions" :key="index">
          <label>Nombre</label>
          <input v-model="interaction.name"
                 :name="`interactions[${index}][name]`" type="text" placeholder="Visita presencial">

          <label>Cantidad permitida de personas</label>
          <input v-model="interaction.allowed_attendees"
                 :name="`interactions[${index}][allowed_attendees]`" type="number" min="1" placeholder=2>

          <label>Cantidad permitida de veces al día</label>
          <input v-model="interaction.allowed_times_a_day"
                 :name="`interactions[${index}][allowed_times_a_day]`" type="number" min="1" placeholder=2>

          <label>Días NO permitidos</label>
          <select v-model="interaction.csv_not_allowed_days"
                  :name="`interactions[${index}][csv_not_allowed_days]`"
                  :multiple="true"
          >
            <option value="">Ninguno (todos los días se permite)</option>

            <option v-for="(dayName, dayNumber) in weekDays" :key="dayNumber" :value="dayNumber">
              {{ dayName }}
            </option>
          </select>
        </div>

        <div>
          <button @click="addInteraction" type="button" >+ Agregar interacción</button>
        </div>

      </div>
      <button type="submit" name="button">
        Crear fase
      </button>

      <ul>
        <li v-for="(error, index) in errors" :key="index">
          {{ error }}
        </li>
      </ul>
    </form>
  </div>
</template>

<script>
import PhaseService from '@/api/PhaseService.js'

export default {
  data () {
    return {
      name: '',
      interactions: [
        this.emptyInteraction()
      ],
      weekDays: {
        0: 'Domingo',
        1: 'Lunes',
        2: 'Martes',
        3: 'Miércoles',
        4: 'Jueves',
        5: 'Viernes',
        6: 'Sábado'
      },
      errors: null
    }
  },
  methods: {
    addInteraction(){
      this.interactions.push(this.emptyInteraction())
    },
    createPhase () {
      const data = {
        name: this.name,
        interactions: this.adaptInteractions(this.interactions)
      }
      PhaseService.create(data)
        .then(() => {
          alert('Fase creada exitosamente')
          this.$router.push({ name: 'birth_create' })
        })
        .catch(err => {
          this.errors = [err.response.data.error]
        })
    },
    adaptInteractions(interactions){
      return interactions.map(
        interaction => {
          const adapatedInteraction = Object.assign({}, interaction)
          adapatedInteraction.allowed_attendees = parseInt(interaction.allowed_attendees)
          adapatedInteraction.allowed_times_a_day = parseInt(interaction.allowed_times_a_day)
          adapatedInteraction.csv_not_allowed_days = interaction.csv_not_allowed_days.join(',')
          return adapatedInteraction
        }
      )
    },
    emptyInteraction() {
     return {
       name: "",
       allowed_attendees: 1,
       allowed_times_a_day: 1,
       csv_not_allowed_days: [""]
     }
    }
  }
}
</script>

<style scoped>

  .interaction {
    padding: 1em;
    margin: 2px;
    border: 1px solid #16c0b0;
  }

</style>
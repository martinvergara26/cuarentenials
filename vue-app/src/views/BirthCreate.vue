<template>
  <div class="home">
    <h4>Dar de alta nacimiento</h4>
    
    <form @submit.prevent="createBirth">
      <label for="name">
        Nombre y apellido
      </label>
      <input v-model="name" type="name" name="name" value>

      <label for="estimated_date">
        Fecha probable
      </label>
      <date-picker
        name="estimated_date"
        v-model="estimated_date"
      />

      <label for="phase_id">
        Fase
      </label>
      <select v-model="phase_id">
        <option disabled value="">Fase</option>
        <option v-for="phase in phases" :key="phase.id" :value="phase.id">
          {{ phase.name }}
        </option>
      </select>

      <div>
        <button @click="goToPhaseCreate">
          Crear mi fase personalizada
        </button>
      </div>

      <button type="submit" name="button">
        Crear
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
import DatePicker from 'vue3-datepicker';
import BirthService from '@/api/BirthService.js'
import PhaseService from '@/api/PhaseService.js'

export default {
  data () {
    return {
      name: '',
      estimated_date: null,
      phases: [],
      phase_id: null,
      errors: null,
    }
  },
  created() {
    PhaseService.getPhases()
      .then(({data}) => {
        this.phases = data
      })
      .catch(error => {
        console.log(error.response)
      })
  },
  methods: {
    createBirth () {
      const data = {
        name: this.name,
        estimated_date: this.estimated_date,
        phase_id: this.phase_id
      }
      BirthService.createBirth(data)
        .then(() => {
          this.$router.push({ name: 'my_births' })
        })
        .catch(error => {
          console.log(error.response)
        })
    },
    goToPhaseCreate() {
      this.$router.push({ name: 'create_phase' })
    }
  },
  components: { DatePicker }
}
</script>
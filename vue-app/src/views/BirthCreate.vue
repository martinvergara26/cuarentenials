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

      <label for="phase">
        Fase
      </label>
      <select v-model="phase">
        <option disabled value="">Fase</option>
        <option v-for="phase_option in phases" :key="phase_option.id" :value="phase_option.id">
          {{ phase_option.name }}
        </option>
      </select>

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
      phase: null,
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
        phase: this.phase
      }
      BirthService.createBirth(data)
        .then(() => {
          alert('Creado!!!!')
        })
        .catch(error => {
          console.log(error.response)
        })
    }
  },
  components: { DatePicker }
}
</script>
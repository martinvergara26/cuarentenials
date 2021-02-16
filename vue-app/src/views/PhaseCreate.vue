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

        <div v-for="(interaction, index) in interactions" :key="index">
          <div>
            <label>Nombre</label>
            <input v-model="interaction.name"
                   :name="`interactions[${index}][name]`" type="text" placeholder="Visita presencial">
          </div>
        </div>

        <div>
          <button @click="addInteraction" type="button" >Agregar interacción</button>
        </div>

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
import PhaseService from '@/api/PhaseService.js'

export default {
  data () {
    return {
      name: '',
      interactions: [
        {
          name: ""
        }
      ],
      errors: null
    }
  },
  methods: {
    addInteraction(){
      this.interactions.push({
        name: "Tu interacción"
      })
    },
    createPhase () {
      const data = {
        name: this.name,
        interactions: this.interactions
      }
      PhaseService.create(data)
        .then(() => {
          alert('Fase creada exitosamente')
          this.$router.push({ name: 'birth_create' })
        })
        .catch(err => {
          this.errors = [err.response.data.error]
        })
    }
  }
}
</script>
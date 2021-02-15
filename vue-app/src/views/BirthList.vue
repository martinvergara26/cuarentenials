<template>
  <div class="home">
    <h1>Listado de nacimientos</h1>
     <table style="width:100%">
      <tr>
        <th>Nombre y apellido</th>
        <th>Fecha probable de nacimiento</th>
        <th>Fase</th>
        <th>Acciones</th>
      </tr>
      <tr v-for="birth in births" :key="birth.id">
        <td>{{ birth.name }}</td>
        <td>{{ birth.estimated_date }}</td>
        <td>{{ birth.phase.name }}</td>
        <td>Programar interacción</td>
      </tr>
    </table> 
    <ul>
    </ul>
  </div>
</template>

<script>
import BirthService from '@/api/BirthService.js'
    
export default {
  data() {
    return {
      births: []
    }
  },
  created() {
    BirthService.getBirths()
      .then(response => {
        this.births = response.data
      })
      .catch(error => {
        console.log(error.response)
      })
  }
}
</script>
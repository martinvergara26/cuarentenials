<template>
  <div class="home">
    <h1>Mis nacimientos</h1>
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
        <td>
          <router-link :to="{ name: 'my_birth_details', params: { id: birth.id } }">
            Ver detalles
          </router-link>
        </td>
      </tr>
    </table> 

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
    BirthService.getMyBirths()
      .then(response => {
        this.births = response.data
      })
      .catch(error => {
        console.log(error.response)
      })
  }
}
</script>
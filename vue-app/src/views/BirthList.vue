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
        <td>
          <router-link :to="{ name: 'birth_details', params: { id: birth.id } }">
            Programar interacción
          </router-link>
        </td>
      </tr>
    </table>

    <router-link to="/birth_create" v-if="loggedIn && isPMC">
      <button v-if="isPMC" name="button">
        Dar de alta nacimiento
      </button>
    </router-link>
  </div>
</template>

<script>
import BirthService from '@/api/BirthService.js'
import { authComputed } from '@/vuex/helpers.js'

export default {
  data() {
    return {
      births: []
    }
  },
  computed: {
    ...authComputed
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
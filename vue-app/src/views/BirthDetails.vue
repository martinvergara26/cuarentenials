<template>
  <div class="home">
    <h4>{{ birth.name }} está por nacer!</h4>
     <div>
       Podés regalar alguno de estos disponibles:
     </div>
    <table style="width:100%">
      <tr>
        <th>Regalo</th>
        <th>Acciones</th>
      </tr>
      <tr v-for="gift in birth.phase.gifts" :key="gift.id">
        <td>{{ gift.name }}</td>
        <td>Regalar!</td>
      </tr>
    </table> 

    <h4>
      O agendar una call
    </h4>

  </div>
</template>

<script>
import BirthService from '@/api/BirthService.js'
import { authComputed } from '@/vuex/helpers.js'

export default {
  props: ['id'],
  data() {
    return {
      birth: {
        phase: {
          gifts: []
        }
      }
    }
  },
  computed: {
    ...authComputed
  },
  created() {
    BirthService.getBirth(this.id)
      .then(({data}) => {
        this.birth = data
      })
      .catch(error => {
        console.log(error.response)
      })
  }
}
</script>
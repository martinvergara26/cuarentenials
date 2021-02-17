<template>
  <div class="home">
    <h4>Crear un regalo personalizado</h4>
    
    <form @submit.prevent="createCustomGift">
      <label for="name">
        Nombre del regalo
      </label>
      <input v-model="name" type="name" name="name" value>

      <div>
        <button type="submit">Crear regalo</button>
      </div>

      <ul>
        <li v-for="(error, index) in errors" :key="index">
          {{ error }}
        </li>
      </ul>
    </form>
  </div>
</template>

<script>
import GiftService from '@/api/GiftService.js'

export default {
  props: ['birth_id'],
  data() {
    return {
      name : ""
    }
  },
  methods: {
    createCustomGift () {
      const data = {
        name: this.name,
        birth_id: this.birth_id
      }
      GiftService.createCustomGift(data)
        .then(() => {
          alert('Regalo agregado a tu lista!')
          location.reload()
        })
        .catch(error => {
          console.log(error.response)
        })
    }
  }
}
</script>
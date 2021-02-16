<template>
  <div class="home">
    <h4 v-if="gift != null">{{ gift.gift.name }}</h4>


    <div class="container">
      <form @submit.prevent="assignPriority">
        <label for="priority">Prioridad</label>
        <input v-model="priority" :name="priority" type="number"
               min="1" max="10">

        <button type="submit">
          Asignar prioridad
        </button>
      </form>
    </div>


    <button @click="markAsGiven">
      Marcar como regalado
    </button>

    <button class="warning-button" @click="deleteGift">
      Borrar regalo
    </button>

    <button @click="goToMyBirthDetails">
      Cancelar
    </button>

  </div>
</template>

<script>
import GivenGiftService from '@/api/GivenGiftService.js'


export default {
  props: ['gift_id', 'birth_id'],
  data() {
    return {
      gift: {
        gift: {
          name: ""
        }
      },
      priority: 10
    }
  },
  created() {
    GivenGiftService.get(this.gift_id)
      .then(({data}) => {
        this.gift = data
      })
      .catch(error => {
        console.log(error.response)
      })
  },
  methods: {
    markAsGiven() {
      GivenGiftService.setAsGiven(this.gift_id)
        .then(() => {
          this.goToMyBirthDetails()
        })
        .catch(error => {
          console.log(error.response)
        })
    },
    deleteGift() {
      GivenGiftService.deleteGivenGift(this.gift_id)
        .then(() => {
          this.goToMyBirthDetails()
        })
        .catch(error => {
          console.log(error.response)
        })
    },
    assignPriority () {
      GivenGiftService.setPriority(this.gift_id, parseInt(this.priority))
        .then(() => {
          this.goToMyBirthDetails()
        })
        .catch(error => {
          console.log(error.response)
        })
    },
    goToMyBirthDetails() {
      this.$router.push({ name: 'my_birth_details', params: {id: this.birth_id }})
    }
  }
}
</script>
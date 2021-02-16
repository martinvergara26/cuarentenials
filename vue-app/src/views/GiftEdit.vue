<template>
  <div class="home">
    <h4>{{ gift.name }}</h4>

    <div></div>

    <button class="warning-button" @click="deleteGift">
      Borrar regalo
    </button>

    <button @click="goToMyBirthDetails">
      Cancelar
    </button>

  </div>
</template>

<script>
import GiftService from '@/api/GiftService.js'


export default {
  props: ['gift_id', 'birth_id'],
  data() {
    return {
      gift: {}
    }
  },
  created() {
    GiftService.getGift(this.gift_id)
      .then(({data}) => {
        this.gift = data
      })
      .catch(error => {
        console.log(error.response)
      })
  },
  methods: {
    deleteGift() {
      GiftService.deleteGift(this.gift_id)
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
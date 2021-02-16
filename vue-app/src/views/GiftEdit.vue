<template>
  <div class="home">
    <h4>{{ gift.gift.name }}</h4>

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
import GivenGiftService from '@/api/GivenGiftService.js'


export default {
  props: ['gift_id', 'birth_id'],
  data() {
    return {
      gift: {}
    }
  },
  created() {
    GivenGiftService.get(this.gift_id)
      .then(({data}) => {
        debugger
        this.gift = data
      })
      .catch(error => {
        console.log(error.response)
      })
  },
  methods: {
    deleteGift() {
      GivenGiftService.deleteGivenGift(this.gift_id)
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
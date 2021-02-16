<template>
  <div class="home">
    <h4>{{ gift.name }}</h4>

    <div></div>

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
    goToMyBirthDetails() {
      this.$router.push({ name: 'my_birth_details', params: {id: this.birth_id }})
    }
  }
}
</script>
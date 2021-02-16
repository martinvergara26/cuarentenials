<template>
  <div class="home">
    <h4>Detalles de {{ birth.name }}</h4>
     <div>
       Sus regalos
     </div>
    <table style="width:100%">
      <tr>
        <th>Regalo</th>
        <th>Estado</th>
        <th>Acciones</th>
      </tr>
      <tr v-for="gift in birth.phase.gifts" :key="gift.id">
        <td>{{ gift.name }}</td>
        <td class="given-gift" v-if="isAlreadyGiven(gift)">Ya fue regalado!</td>
        <td class="not-given-gift" v-else>-</td>
        <td>
          <button v-if="!isAlreadyGiven(gift)" @click="() => goToEdit(gift)">
            Editar
          </button>
          <span v-else>-</span>
        </td>
      </tr>
    </table> 

    <TimeslotCreate :birth_id="id" />

    <TimeslotList :birth_id="id" />

  </div>
</template>

<script>
import BirthService from '@/api/BirthService.js'
import GivenGiftService from '@/api/GivenGiftService.js'
import { authComputed } from '@/vuex/helpers.js'
import TimeslotCreate from "../components/TimeslotCreate";
import TimeslotList from "../components/TimeslotList";

export default {
  components: {TimeslotList, TimeslotCreate},
  props: ['id'],
  data() {
    return {
      birth: {
        phase: {
          gifts: []
        }
      },
      givenGifts: []
    }
  },
  methods: {
    isAlreadyGiven(gift) {
      return this.givenGifts.some(givenGift => givenGift.gift_id === gift.id)
    },
    addGivenGift(gift) {
      GivenGiftService.postGivenGift(this.id, gift.id)
      .then(() => {
        alert(`Felicidades! Regalaste: ${gift.name}`)
        this.loadGivenGifts()
      })
      .catch(error => {
        console.log(error.response)
      })
    },
    loadGivenGifts() {
      GivenGiftService.getGivenGifts(this.id)
      .then(({data}) => {
        this.givenGifts = data
      })
      .catch(error => {
        console.log(error.response)
      })
    },
    goToEdit(gift) {
      this.$router.push({ name: 'gift_edit', params: {id: gift.id }})
    }
  },
  computed: {
    ...authComputed
  },
  created() {
    this.loadGivenGifts()

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
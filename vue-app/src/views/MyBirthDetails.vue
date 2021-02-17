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
      <tr v-for="gift in givenGifts" :key="gift.id">
        <td>{{ gift.gift.name }}
          <span v-show="gift.priority != null">{{ formatPriority(gift) }}</span>
        </td>
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

    <div class="container">
      <CustomGiftCreate :birth_id="id" />
    </div>

    <div class="container">
      <TimeslotCreate :birth_id="id" />
    </div>

    <div class="container">
      <TimeslotList :birth_id="id" />
    </div>

  </div>
</template>

<script>
import BirthService from '@/api/BirthService.js'
import GivenGiftService from '@/api/GivenGiftService.js'
import { authComputed } from '@/vuex/helpers.js'
import TimeslotCreate from "../components/TimeslotCreate";
import TimeslotList from "../components/TimeslotList";
import CustomGiftCreate from "../components/CustomGiftCreate";

export default {
  components: {CustomGiftCreate, TimeslotList, TimeslotCreate},
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
      return gift.user_id != null
    },
    loadGivenGifts() {
      GivenGiftService.getGivenGifts(this.id)
      .then(({data}) => {
        this.givenGifts = data.sort(
          (gift1, gift2) => {
            return Math.max(0, gift2.priority) - Math.max(0, gift1.priority)
          }
        )
      })
      .catch(error => {
        console.log(error.response)
      })
    },
    goToEdit(gift) {
      this.$router.push({ name: 'gift_edit', params: {birth_id: this.id, gift_id: gift.id }})
    },
    formatPriority(gift){
      return `(Prioridad: ${gift.priority})`
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
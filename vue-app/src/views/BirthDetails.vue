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
      <tr v-for="gift in givenGifts" :key="gift.id">
        <td>{{ gift.gift.name }}</td>
        <td v-if="isAlreadyGiven(gift)">Ya fue regalado</td>
        <td v-else>
           <button @click="() => addGivenGift(gift)">
            Regalar!
          </button>
        </td>
      </tr>
    </table> 

    <BirthAvailableTimeslots v-if="birth.phase_id" :birth_id="id" :phase_id="birth.phase_id" />

  </div>
</template>

<script>
import BirthService from '@/api/BirthService.js'
import GivenGiftService from '@/api/GivenGiftService.js'
import BirthAvailableTimeslots from "../components/BirthAvailableTimeslots";

export default {
  components: {BirthAvailableTimeslots},
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
    addGivenGift(gift) {
      GivenGiftService.setAsGiven(gift.id)
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
    }
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
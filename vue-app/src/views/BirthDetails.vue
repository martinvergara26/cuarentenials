<template>
  <div class="home">
    <h4>{{ birth.name }} está por nacer! (PMC: {{ birth.user.email }})</h4>
    <div class="container">
      <div>
         Podés regalar alguno de estos disponibles:
       </div>
      <table style="width:100%">
        <tr>
          <th>Regalo</th>
          <th>Acciones</th>
        </tr>
        <tr v-for="gift in givenGifts" :key="gift.id">
          <td>{{ gift.gift.name }}
            <span v-show="gift.priority != null">{{ formatPriority(gift) }}</span>
          </td>
          <td v-if="isAlreadyGiven(gift)">Ya fue regalado</td>
          <td v-else>
             <button v-if="gift.gift.approved" @click="() => addGivenGift(gift)">
              Regalar!
             </button>
            <span v-else>Pendiente de aprobación</span>
          </td>
        </tr>
      </table>
    </div>
    <div class="container">
      O solicitá un nuevo regalo:
      <div>
        <CustomGiftCreate :birth_id="id" />
      </div>
    </div>

    <div class="container">
      O agendá una interacción:
      <BirthAvailableTimeslots v-if="birth.phase_id" :birth_id="id" :phase_id="birth.phase_id" />
    </div>

    <div class="container">
      <CustomInteractionCreate :birth_id="id" />
    </div>

  </div>
</template>

<script>
import BirthService from '@/api/BirthService.js'
import GivenGiftService from '@/api/GivenGiftService.js'
import BirthAvailableTimeslots from "../components/BirthAvailableTimeslots";
import CustomGiftCreate from "../components/CustomGiftCreate";
import CustomInteractionCreate from "../components/CustomInteractionCreate";

export default {
  components: {CustomInteractionCreate, CustomGiftCreate, BirthAvailableTimeslots},
  props: ['id'],
  data() {
    return {
      birth: {
        user: {
          email: "" // Muestro mail para facilitar demo y uso del sistema
        },
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
        alert(`Felicidades! Regalaste: ${gift.gift.name}`)
        this.loadGivenGifts()
      })
      .catch(error => {
        console.log(error.response)
      })
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
    formatPriority(gift){
      return `(Prioridad: ${gift.priority})`
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
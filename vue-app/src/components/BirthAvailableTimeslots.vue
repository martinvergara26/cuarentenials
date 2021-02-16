<template>
  <div class="home">
    <h4>Agendar una interacción</h4>

    <table style="width:100%">
      <tr>
        <th>Timeslot</th>
        <th>Interacciones disponibles</th>
      </tr>
      <tr v-for="timeslot in timeslots" :key="timeslot.id">
        <td>{{ timeslot.from }} hasta {{ timeslot.to }}</td>
        <td>
          <button v-for="interaction in interactionsOfTimeslot(timeslot)"
                  :key="interaction.id">
            {{ interaction.name }}
          </button>
        </td>
      </tr>
    </table>

  </div>
</template>

<script>
  import TimeslotService from '@/api/TimeslotService.js'
  import InteractionService from '@/api/InteractionService.js'

  export default {
    props: ['birth_id', 'phase_id'],
    data() {
      return {
        timeslots: [],
        phaseInteractions: []
      }
    },
    created() {
      TimeslotService.getAllAvailable(this.birth_id)
        .then(({data}) => {
          this.timeslots = this.adaptTimeslots(data)
        })
        .catch(error => {
          console.log(error.response)
        })
      InteractionService.get(this.phase_id)
        .then(({data}) => {
          this.phaseInteractions = data
        })
        .catch(error => {
          console.log(error.response)
        })
    },
    methods: {
      adaptTimeslots(timeslots) {
        return timeslots.map(
          timeslot => {
            timeslot.from = new Date(timeslot.from).toLocaleString()
            timeslot.to = new Date(timeslot.to).toLocaleString()
            return timeslot
          }
        )
      },
      interactionsOfTimeslot(timeslot){
        if(timeslot.interaction_id){
          return [this.findInteraction(timeslot.interaction_id)]
        } else {
          return this.phaseInteractions
        }
      },
      findInteraction(interactionID) {
        return this.phaseInteractions.find(i => i.id === interactionID)
      }
    }
  }
</script>
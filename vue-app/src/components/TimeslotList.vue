<template>
  <div class="home">
    <h4 v-if="timeslots.length">Mis timeslots</h4>
    <h4 v-else>Aún no creaste timeslots</h4>

    <table style="width:100%" v-if="timeslots.length > 0">
      <tr>
        <th>Timeslot</th>
        <th>Estado</th>
        <th>Acciones</th>
      </tr>
      <tr v-for="timeslot in timeslots" :key="timeslot.id">
        <td>
          {{ timeslot.from }} hasta {{ timeslot.to }} {{ formatInteraction(timeslot) }}
        </td>
        <td>
          <span v-if="requiresPMCApproval(timeslot)">
            Pendiente
          </span>
          <span v-else>
            <span v-show="timeslot.interaction_id"> (Ya está agendado)</span>
          </span>
        </td>
        <td>
          <button v-if="requiresPMCApproval(timeslot)" @click="() => approve(timeslot.interaction)">
            Aprobar
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
    props: ['birth_id'],
    data() {
      return {
        timeslots: []
      }
    },
    created() {
      TimeslotService.get(this.birth_id)
        .then(({data}) => {
          this.timeslots = this.adaptTimeslots(data)
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
      requiresPMCApproval(timeslot) {
        return timeslot.interaction && !timeslot.interaction.approved
      },
      approve(interaction) {
        InteractionService.approve(interaction.id)
          .then(() => {
            this.timeslots.find(
              timeslot => timeslot.interaction_id === interaction.id
            ).interaction.approved = true
          })
          .catch(error => {
            console.log(error.response)
          })
      },
      formatInteraction(timeslot){
        if(timeslot.interaction){
          return `| Actividad: ${timeslot.interaction.name}`
        }
      }
    }
  }
</script>
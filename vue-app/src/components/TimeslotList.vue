<template>
  <div class="home">
    <h4>Mis timeslots</h4>

    <ul>
      <li v-for="timeslot in timeslots" :key="timeslot.id">
        {{ timeslot.from }} hasta {{ timeslot.to }}
        <span v-if="timeslot.interaction_id"> (Ya está agendado)</span>
      </li>
    </ul>

  </div>
</template>

<script>
  import TimeslotService from '@/api/TimeslotService.js'

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
      }
    }
  }
</script>
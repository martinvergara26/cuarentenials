<template>
  <div class="home">
    <h4>Mis timeslots</h4>

    <ul>
      <li v-for="timeslot in timeslots" :key="timeslot.id">
        {{ timeslot.from }} hasta {{ timeslot.to }}
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
          this.timeslots = data.map(
            timeslot => {
              timeslot.from = new Date(timeslot.from).toLocaleString()
              timeslot.to = new Date(timeslot.to).toLocaleString()
              return timeslot
            }
          )
        })
        .catch(error => {
          console.log(error.response)
        })
    }
  }
</script>
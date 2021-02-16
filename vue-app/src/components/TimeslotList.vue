<template>
  <div class="home">
    <h4>Mis timeslots</h4>

    <ul>
      <li v-for="timeslot in timeslots" :key="timeslot.id">
        {{ timeslot.from }} -  {{ timeslot.to }}
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
          this.timeslots = data
        })
        .catch(error => {
          console.log(error.response)
        })
    }
  }
</script>
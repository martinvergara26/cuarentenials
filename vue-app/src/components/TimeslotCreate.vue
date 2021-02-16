<template>
  <div class="home">
    <h4>Crear un rango de disponibilidad</h4>
    
    <form @submit.prevent="createTimeslot">
      <label for="timeslot_date">
        Fecha
      </label>
      <date-picker
        name="timeslot_date"
        v-model="timeslot_date"
      />
      <label for="from_time">
        Desde
      </label>
      <vue-timepicker :hour-range="[[0, 23]]" :minute-interval="30" v-model="from_time"></vue-timepicker>

      <label>
        Hasta
      </label>
      <vue-timepicker :hour-range="[[0, 23]]" :minute-interval="30" v-model="to_time"></vue-timepicker>

      <button type="submit" name="button">
        Crear
      </button>

      <ul>
        <li v-for="(error, index) in errors" :key="index">
          {{ error }}
        </li>
      </ul>
    </form>
  </div>
</template>

<script>
import DatePicker from 'vue3-datepicker';
import TimeslotService from '@/api/TimeslotService.js'
import VueTimepicker from 'vue3-timepicker'
import 'vue3-timepicker/dist/VueTimepicker.css'

export default {
  props: ['birth_id'],
  data() {
    return {
      ...this.initData()
    }
  },
  methods: {
    initData() {
      return {
        timeslot_date: null,
        from_time: {
          hh: '10',
          mm: '00'
        },
        to_time: {
          HH: '10',
          mm: '00'
        },
        errors: null // TODO puede haber errores por solapamiento
      }
    },
    createDateTime(date, timeData) {
      const createdDate = new Date(date)
      const hours = parseInt(timeData.HH);
      createdDate.setHours(hours)
      const minutes = parseInt(timeData.mm);
      createdDate.setMinutes(minutes)
      return createdDate
    },
    createTimeslot () {
      const timeslotFrom = this.createDateTime(this.timeslot_date, this.from_time)
      const timeslotTo = this.createDateTime(this.timeslot_date, this.to_time)

      const data = {
        from: timeslotFrom,
        to: timeslotTo,
        birth_id: this.birth_id
      }
      TimeslotService.createTimeslot(data)
        .then(() => {
          alert('Timeslot creado con éxito')
          location.reload()
        })
        .catch(error => {
          console.log(error.response)
        })
    }
  },
  components: { DatePicker, VueTimepicker }
}
</script>
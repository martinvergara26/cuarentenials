<template>
  <div class="home">
    <h4>O solicitá agendar una interacción</h4>

    <form @submit.prevent="createCustomInteraction">
      <div>
        <h4>Definí tu interacción</h4>
        <label>Nombre</label>
        <input v-model="interaction.name" type="text" placeholder="Visita presencial">

        <label>Cantidad permitida de personas</label>
        <input v-model="interaction.allowed_attendees" type="number" min="1" placeholder=1>
      </div>

      <div>
        <h4>¿Para cuándo querés agendarla?</h4>
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
      </div>

      <div>
        <button type="submit">Solicitar interacción</button>
      </div>

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
  import VueTimepicker from 'vue3-timepicker'
  import 'vue3-timepicker/dist/VueTimepicker.css'

  import InteractionService from '@/api/InteractionService.js'
  import {adaptInteraction} from '@/util/interactions.js'
  import {createDateTime} from '@/util/datetimes.js'

  export default {
    props: ['birth_id'],
    data() {
      return {
        interaction: {
          allowed_attendees: 1,
          allowed_times_a_day: 1,
          csv_not_allowed_days: [""]
        },
        timeslot_date: null,
        from_time: {
          hh: '10',
          mm: '00'
        },
        to_time: {
          HH: '10',
          mm: '00'
        },
        weekDays: {
          0: 'Domingo',
          1: 'Lunes',
          2: 'Martes',
          3: 'Miércoles',
          4: 'Jueves',
          5: 'Viernes',
          6: 'Sábado'
        },
        errors: []
      }
    },
    methods: {
      createCustomInteraction () {
        const data = {
          birth_id: this.birth_id,
          ...adaptInteraction(this.interaction),
          timeslot: {
            from: createDateTime(this.timeslot_date, this.from_time),
            to: createDateTime(this.timeslot_date, this.to_time)
          }
        }
        InteractionService.createCustomInteraction(data)
          .then(() => {
            alert('Solicitud de interacción enviada')
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
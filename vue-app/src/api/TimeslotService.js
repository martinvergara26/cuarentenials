import client from '@/api/client'

export default {
    createTimeslot(data) {
      return client.post('/timeslots', data)
    }
}
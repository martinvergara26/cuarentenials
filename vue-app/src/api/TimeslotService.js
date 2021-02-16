import client from '@/api/client'

export default {
  get(birth_id) {
    return client.get('/timeslots', {birth_id})
  },
  createTimeslot(data) {
    return client.post('/timeslots', data)
  }
}
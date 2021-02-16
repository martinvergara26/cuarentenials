import client from '@/api/client'

export default {
  get(birth_id) {
    return client.get('/timeslots', { params: {birth_id} })
  },
  getAllAvailable(birth_id) {
    return client.get('/timeslots', { params: {birth_id, available: true} })
  },
  createTimeslot(data) {
    return client.post('/timeslots', data)
  },
  makeAppointment(timeslot_id, interaction_id) {
    return client.put(`/timeslots/${timeslot_id}`, {interaction_id})
  }
}
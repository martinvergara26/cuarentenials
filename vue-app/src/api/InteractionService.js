import client from '@/api/client'

export default {
  get(phase_id) {
    return client.get('/interactions', { params: {phase_id} })
  },
  createCustomInteraction(data) {
    return client.post('/create_custom_interaction', data)
  },
  approve(timeslotID) {
    return client.put(`/interactions/${timeslotID}`, {approved: true})
  }
}
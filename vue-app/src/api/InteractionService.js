import client from '@/api/client'

export default {
  get(phase_id) {
    return client.get('/interactions', { params: {phase_id} })
  }
}
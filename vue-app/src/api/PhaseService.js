import client from '@/api/client'

export default {
    getPhases() {
      return client.get('/phases')
    },
    create(data) {
      return client.post('/phases', data)
    }
}
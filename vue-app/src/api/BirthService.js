import client from '@/api/client'

export default {
    getBirths() {
      return client.get('/births')
    },
    getBirth(id) {
      return client.get(`/births/${id}`)
    }
  }
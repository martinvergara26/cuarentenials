import client from '@/api/client'

export default {
    getBirths() {
      return client.get('/births')
    },
    getMyBirths() {
      return client.get('/my_births')
    },
    getBirth(id) {
      return client.get(`/births/${id}`)
    }
  }
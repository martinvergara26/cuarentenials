import client from '@/api/client'

export default {
    getAll() {
      return client.get('/gifts')
    },
    getGift(id) {
      return client.get(`/gifts/${id}`)
    }
}
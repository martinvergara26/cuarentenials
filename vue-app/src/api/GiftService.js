import client from '@/api/client'

export default {
    getAll() {
      return client.get('/gifts')
    },
    createCustomGift(data) {
      return client.post('/create_custom_gift', data)
    },
    deleteGift(id) {
      return client.delete(`/gifts/${id}`)
    },
    approve(id) {
      return client.put(`/gifts/${id}`, {approved: true})
    }
}
import client from '@/api/client'

export default {
    getGivenGifts(birthID) {
      return client.get('/given_gifts', { params: { birth_id: birthID } })
    },
    setAsGiven(givenGiftID) {
      return client.put(`/given_gifts/${givenGiftID}`)
    },
    deleteGivenGift(id) {
      return client.delete(`/given_gifts/${id}`)
    },
    get(id) {
      return client.get(`/given_gifts/${id}`)
    }
}
import client from '@/api/client'

export default {
    getGivenGifts(birthID) {
      return client.get('/given_gifts', { params: { birth_id: birthID } })
    },
    postGivenGift(birthID, giftID) {
      return client.post('/given_gifts', { birth_id: birthID, gift_id: giftID })
    }
  }
import client from '@/api/client'

export default {
    getGivenGifts(birthID) {
      return client.get('/given_gifts', { birth_id: birthID })
    }
  }
import client from '@/api/client'

export default {
    getAll() {
      return client.get('/gifts')
    }
  }
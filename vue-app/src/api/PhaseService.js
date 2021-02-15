import client from '@/api/client'

export default {
    getPhases() {
      return client.get('/phases')
    }
}
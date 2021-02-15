import axios from 'axios'

const client = axios.create({
  baseURL: 'http://localhost:3000',
  headers: {
    Accept: 'application/json',
    'Content-Type': 'application/json'
  }
})

export const setApiClientToken = authToken => {
  client.defaults.headers.common['Authorization'] = authToken
}

const authToken = localStorage.getItem('authToken')
if (authToken) {
  setApiClientToken(authToken)
}

export default client
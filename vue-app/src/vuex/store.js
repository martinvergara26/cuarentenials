import Vuex from 'vuex'
import client, { setApiClientToken } from '@/api/client'

export default new Vuex.Store({
  state: {
    user: null
  },
  mutations: {
    SET_USER_DATA (state, {data, authToken}) {
      state.user = data
      setApiClientToken(authToken)
    },
    CLEAR_USER_DATA () {
      localStorage.removeItem('user')
      localStorage.removeItem('authToken')
      location.reload()
    }
  },
  actions: {
    signUp (context, credentials) {
      return client
        .post('/users/sign_up', {
          user: {
            ...credentials
          }
        })
    },
    signIn ({ commit }, credentials) {
      return client
        .post('/users/sign_in', {
          user: {
            ...credentials
          }
        })
        .then(({ data, headers }) => {
          const authToken = headers.authorization
          localStorage.setItem('user', JSON.stringify(data))
          localStorage.setItem('authToken', JSON.stringify(authToken)) 
          
          commit('SET_USER_DATA', {data, authToken})
        })
    },
    signOut ({ commit }) {
      commit('CLEAR_USER_DATA')
    }
  },
  getters: {
    loggedIn (state) {
      return !!state.user
    },
    isPMC (state) {
      return state.user.is_pmc
    }
  }
})

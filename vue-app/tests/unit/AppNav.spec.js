import AppNav from '@/components/AppNav'
import { shallowMount, createLocalVue, RouterLinkStub } from '@vue/test-utils'
import Vuex from 'vuex'

const localVue = createLocalVue()

localVue.use(Vuex)

describe('AppNav', () => {
  let getters
  let store

  test('if user is not logged in, do not show logout button', () => {
    getters = {
      loggedIn: () => false,
      isPMC: () => false
    }

    store = new Vuex.Store({
      getters
    })

    const wrapper = shallowMount(AppNav, { store, localVue })
    expect(wrapper.find('button').exists()).toBe(false)
  })

  test('if logged in and not PMC, show logout button but not /my_births link', async () => {
    getters = {
      loggedIn: () => true,
      isPMC: () => false
    }

    store = new Vuex.Store({
      getters
    })

    const wrapper = shallowMount(AppNav, { store, localVue,
      stubs: {
        RouterLink: RouterLinkStub
      }
    })
    expect(wrapper.find('button').isVisible()).toBe(true)
    expect(wrapper.find('#mi-births-link').exists()).toBe(false)
  })

  test('if logged in, and is PMC, show /my_births link', async () => {
    getters = {
      loggedIn: () => true,
      isPMC: () => true
    }

    store = new Vuex.Store({
      getters
    })

    const wrapper = shallowMount(AppNav, { store, localVue,
      stubs: {
        RouterLink: RouterLinkStub
      }
    })
    expect(wrapper.find('button').isVisible()).toBe(true)
    expect(wrapper.find('#mi-births-link').isVisible()).toBe(true)
  })
})
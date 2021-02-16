import MyBirthDetails from '@/views/MyBirthDetails'
import BirthService from '@/api/BirthService.js'
import GivenGiftService from '@/api/GivenGiftService.js'
import flushPromises from 'flush-promises'
import { shallowMount } from '@vue/test-utils'

jest.mock('@/api/BirthService.js')
jest.mock('@/api/GivenGiftService.js')


describe('MyBirthDetails', () => {
  beforeEach(() => {
    jest.clearAllMocks()
  })

  test('if backend with N given gifts, and M phase gifts, validate rendered gifts amount', async () => {
    const mockGivenGifts = [
      {
        gift_id: 1,
        name: 'B1',
      },
      {
        gift_id: 2,
        name: 'B2'
      }
    ]

    const mockBirth = {
      name: 'B1',
      estimated_date: 'Some date',
      phase: {
        name: 'Some phase',
        gifts: [
          {
            gift_id: 1,
            name: 'B1',
          },
          {
            gift_id: 2,
            name: 'B2'
          }
        ]
      }
    }

    GivenGiftService.getGivenGifts.mockResolvedValueOnce({ data: mockGivenGifts })
    BirthService.getBirth.mockResolvedValueOnce({ data: mockBirth })

    const wrapper = shallowMount(MyBirthDetails)

    await flushPromises()

    expect(GivenGiftService.getMyBirths).toHaveBeenCalledTimes(1)
    expect(BirthService.getMyBirths).toHaveBeenCalledTimes(1)

    const notGivenGifts = wrapper.find('.not-given-gifts')
    expect(notGivenGifts.length).toEqual(mockGivenGifts.length)

    const givenGifts = wrapper.find('.given-gifts')
    expect(givenGifts.length).toEqual(mockBirth.phase.gifts.length - mockGivenGifts.length)
  })

})
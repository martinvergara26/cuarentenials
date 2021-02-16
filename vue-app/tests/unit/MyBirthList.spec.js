import MyBirthList from '@/views/MyBirthList'
import BirthService from '@/api/BirthService.js'
import flushPromises from 'flush-promises'
import { mount } from '@vue/test-utils'

jest.mock('@/api/BirthService.js')


describe('MyBirthList', () => {
  beforeEach(() => {
    jest.clearAllMocks()
  })

  test('if backend responds with N births, table should render N birth-rows', async () => {
    const mockBirths = [
      {
        name: 'B1',
        estimated_date: 'Some date',
        phase: {
          name: 'Some phase'
        }
      },
      {
        name: 'B2',
        estimated_date: 'Some other date',
        phase: {
          name: 'Some phase'
        }
      }
    ]

    BirthService.getMyBirths.mockResolvedValueOnce({ data: mockBirths })

    const wrapper = mount(MyBirthList)

    await flushPromises()

    expect(BirthService.getMyBirths).toHaveBeenCalledTimes(1)

    const birthRows = wrapper.find('.birth-row')
    expect(birthRows.length).toEqual(mockBirths.length)
  })

})
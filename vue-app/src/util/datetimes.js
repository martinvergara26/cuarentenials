export const createDateTime = (date, timeData) => {
  const createdDate = new Date(date)
  const hours = parseInt(timeData.HH)
  createdDate.setHours(hours)
  const minutes = parseInt(timeData.mm)
  createdDate.setMinutes(minutes)
  return createdDate
}
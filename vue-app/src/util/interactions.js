export const adaptInteraction = interaction => {
  const adapatedInteraction = Object.assign({}, interaction)
  adapatedInteraction.allowed_attendees = parseInt(interaction.allowed_attendees)
  adapatedInteraction.allowed_times_a_day = parseInt(interaction.allowed_times_a_day)
  adapatedInteraction.csv_not_allowed_days = interaction.csv_not_allowed_days.join(',')
  return adapatedInteraction
}

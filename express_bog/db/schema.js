const mongoose = require('mongoose')

const Schema = mongoose.Schema

const CreatureSchema = new Schema({
  name: String,
  description: String
})

const Creature = mongoose.model('Creature', CreatureSchema)

// Export each model so they can be required elsewhere
module.exports = {
  Creature
}

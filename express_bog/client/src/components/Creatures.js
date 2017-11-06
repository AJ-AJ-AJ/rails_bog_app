import React, { Component } from 'react'
import axios from 'axios'
class Creatures extends Component {
  state = {
    creatures: []
  }
  async componentWillMount () {
    const res = await axios.get('/api/creatures')
    this.setState({creatures: res.data})
  }
  render () {
    return (
      <div>
        {this.state.creatures.map(creature => (
          <div key={creature._id}>
            <p>{creature.name}</p>
            <p>{creature.description}</p>
          </div>
        ))}
      </div>
    )
  }
}

export default Creatures

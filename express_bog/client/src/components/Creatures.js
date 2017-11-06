import React, { Component } from 'react'
import { Link } from 'react-router-dom'
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
          <Link key={creature._id} to={`/${creature._id}`}>
            <p>{creature.name}</p>
            <p>{creature.description}</p>
          </Link>
        ))}
      </div>
    )
  }
}

export default Creatures

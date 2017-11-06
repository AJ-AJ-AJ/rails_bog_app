# <img src="https://cloud.githubusercontent.com/assets/7833470/10899314/63829980-8188-11e5-8cdd-4ded5bcb6e36.png" height="60"> MERN Stack Bog App

### Overview

Everyone does blog apps. Now, you're going to work on a **bog app**. Researchers are collecting data on a local bog and need an app to quickly record field data.

### Objectives

It's time to put all your React and Express knowledge into practice! In this project, you will:

- Review **CRUD** in the context of a MERN application.
- Build Forms and communicate with a back end using React
- Build memory for the steps required to create an Express app.


### Workflow

You'll work through this project as a "time trial." You will be building the app 4 times, each time gaining skills through repetition. Here's how we want you to work:

  1. Start by making a parent folder that will hold each of your trial apps.
  1. Move through the instructions below to build your bog app. Use as many hints as you'd like to check your work and make sure you get through the lab smoothly. Commit your work along the way and at the conclusion. If you get stuck at any point, feel free to reference the [solution branch](../../tree/solution). Take notes on your workflow.
  1. When you've finished a run, go back to the parent folder and make a new rails app. Make sure you name it differently (e.g. `bog-app-one`, `bog-app-two`)! Watch out that you're not in a nested rails app folder!
  1. Go through the lab another time. This time, time yourself on how long it takes you. Push yourself to peek at the hints more sparingly and code as much as you can on your own. Try not reference the solution; you can look at your first rails app if you're stuck.  Again, make sure to commit your work.
  1. Repeat the lab a third time. Try not to use the instructions to build your bog app and refer to them only when very stuck. Time yourself again and aim to build the app faster than you built it the second time around. Make sure you have roughly the same number of commits as you had on your second run. Version control isn't the place to cut corners!
  1. Repeat the lab a fourth time. Time yourself. Try to streamline your process. Squash bugs faster and try not to look at any resources. Commit often and build it as fast as you can!


<img src="https://camo.githubusercontent.com/d758d1c1a85e7829d11df73ea25820533db881e7/687474703a2f2f692e67697068792e636f6d2f545467647a75545766784d566439716a4262712e676966" width="40%">

### Submission

When you're finished with your timed runs, edit the README to add an introduction paragraph that includes:

 - a 3-5 sentences reflection on how this went for you  
 - a tip for others to help conquer some part of the app that used to trip you up  
 - the times for your first and fourth runs


## Background

> A bog is a mire that accumulates peat, a deposit of dead plant material — often mosses.

You may hear bog and think of Yoda and Luke...

![](https://cloud.githubusercontent.com/assets/7833470/11500466/211c115a-97e2-11e5-9b7f-9fc900023d8d.jpeg)

Or maybe Sir Didymus and The Bog of Eternal Stench...

![](https://cloud.githubusercontent.com/assets/7833470/11500467/212e3c7c-97e2-11e5-9256-ca7e28cf6941.gif)

## CRUD and REST Reference

REST stands for **REpresentational State Transfer**. We will strictly adhere to RESTful *routing*.

| Verb | Path | Action | Used for |
| :--- | :--- | :--- | :--- |
| GET | /creatures | index | displaying list of all creatures |
| GET | /creatures/new | new | displaying an HTML form to create a new creature |
| POST | /creatures | create | creating a new creature in the database |
| GET | /creatures/:id | show | displaying a specific creature |
| GET | /creatures/:id/edit | edit | displaying an HTML form to edit a specific creature |
| PUT or PATCH | /creatures/:id | update | updating a specific creature in the database |
| DELETE | /creatures/:id | destroy | deleting a specific creature in the database |

## Part I: Getting Started 

![](https://camo.githubusercontent.com/58b675eee577ccb1f4b57b14e58761b3fa56a3b8/687474703a2f2f692e67697068792e636f6d2f313149334f7346524c6b514951552e676966)

#### 0. Create a folder that will (eventually) contain four rails apps
Only do this step the first time:

```bash
mkdir bog-app-time-trials
cd bog-app-time-trials
```

#### 1. Set up a new Express project
(Write down your start time!!!)

Create a new Express project:

Take a look at some previous examples to refresh you on how to set up an express app.[Sample Project 3](https://github.com/dphurley/sample_project_three)

#### 2. Add a `db` directory and create a Mongoose model for Creatures
Define a new mongoose schema for Creatures and give it two attributes: `name` and `description`.

Also create a seeds.js file and add a few test creatures to your database.  Verify that this works via the mongo command line.

Example: 
```js
// ./db/seeds.js
require('dotenv').config()
const mongoose = require('mongoose')
const { Creature } = require('./schema')

mongoose.Promise = global.Promise
mongoose.connect(process.env.MONGODB_URI)

const db = mongoose.connection

const saved = async () => {
  await Creature.remove()
  const luke = new Creature({name: 'Luke', description: 'Jedi'})
  await luke.save()
  const darth = new Creature({name: 'Darth Vader', description: 'Father of Luke'})
  await darth.save()
  db.close()
}

saved()
```

#### 3. Create a routes directory and build out RESTful API routes for creatures.

Make sure to import your routes into your `app.js` file.

Make sure there are routes for each RESTful action.
- Get All Creatures
- Get One Creature by Id
- Create New Creature
- Update A Creature
- Delete A Creature

Use Postman to test each routes

#### 4. Use `create-react-app` to build your client directory

Once you have a working API, it's now time to tie that to a React app.

Initialize your React app by running this command in the root of your directory. Additionally, let's go ahead and install some packages we will use in React

```bash
create-react-app client
cd client
npm i axios styled-components react-router-dom
```

#### 5. Set up your proxy and express app to handle React

Add a proxy to hit your local API in your client `package.json`
```json
...
 "version": "0.1.0",
  "private": true,
  "proxy": "http://localhost:3001",
  "dependencies": {
...
```

Also make sure to add a postinstall and dev step to the root package.json to help Heroku know how to deploy your app.

```json
 "scripts": {
    "start": "node app.js",
    "dev": "concurrently \"node app.js\" \"cd client && npm start\"",
    "test": "echo \"Error: no test specified\" && exit 1",
    "postinstall": "cd client && npm i && npm run build"
  },
```

You should now be able to run both your API and React app by using the command `npm run dev`

#### 6. Set up React Router and create Components for Routes

First we will get rid of the boilerplate code in `App.js` and replace it with some `react-router` code

```jsx
import React, { Component } from 'react'
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom'
import Creatures from './components/Creatures'
import SingleCreature from './components/SingleCreature'

class App extends Component {
  render () {
    return (
      <Router>
        <div>
          <Switch>
            <Route exact path="/" component={Creatures}/>
            <Route path="/:id" component={SingleCreature}/>
          </Switch>
        </div>
      </Router>
    )
  }
}

export default App
```

#### 7. Read All and Create New
Use the `Creatures` component to house components that allow you to get all creatures and also add a toggle to show and hide a form to create a new creature

#### 8. Read One, Update, and Delete
Use the `SingleCreature` component to house components that allow you to get one creature, toggle a form to update the creature, and delete a creature

#### 9. Introduce Styled Components
Once you have the usability for creatures, use styled components to style your application

## Additional Development Ideas for after Version 4

* Add links to other pages to help users navigate your site. For instance, a creature show page might have a link to the creatures index page. Use `Link`.  Also link each creature on the `Creatures` component to its individual `show` page.
* If you'd like, add a `navbar` with links to the homepage (`/`).  Make a new route called `/new` which will open the Creatures component, but set the form toggle to true by default.  This navbar should show up on every page. Take advantage of whichever CSS library you chose to include!
* Read about [Mongoose Validations](http://mongoosejs.com/docs/validation.html), and add validations to the `Creature` model to make sure a new creature can't be created without a `name` and `description`.

## CONGRATULATIONS! You have created a Bog App! Take a break, you look *Swamped*!

![](https://cloud.githubusercontent.com/assets/7833470/11501240/83536030-97e7-11e5-8060-fa7666de7165.jpeg)

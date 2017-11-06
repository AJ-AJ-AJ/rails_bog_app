# <img src="https://cloud.githubusercontent.com/assets/7833470/10899314/63829980-8188-11e5-8cdd-4ded5bcb6e36.png" height="60"> React on Rails Bog App

### Overview

Everyone does blog apps. Now, you're going to work on a **bog app**. Researchers are collecting data on a local bog and need an app to quickly record field data.

### Objectives

It's time to put all your Rails knowledge into practice! In this project, you will:

- Review **CRUD** in the context of a Rails application.
- Implement **form helpers** in a  Rails application.
- Build memory for the steps required to create a Rails app.

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

REST stands for **REpresentational State Transfer**. We will strictly adhere to RESTful *routing* for Rails.

| Verb | Path | Action | Used for |
| :--- | :--- | :--- | :--- |
| GET | /creatures | index | displaying list of all creatures |
| GET | /creatures/new | new | displaying an HTML form to create a new creature |
| POST | /creatures | create | creating a new creature in the database |
| GET | /creatures/:id | show | displaying a specific creature |
| GET | /creatures/:id/edit | edit | displaying an HTML form to edit a specific creature |
| PUT or PATCH | /creatures/:id | update | updating a specific creature in the database |
| DELETE | /creatures/:id | destroy | deleting a specific creature in the database |

## Part I: Display all creatures with `index`

![](https://camo.githubusercontent.com/58b675eee577ccb1f4b57b14e58761b3fa56a3b8/687474703a2f2f692e67697068792e636f6d2f313149334f7346524c6b514951552e676966)

#### 0. Create a folder that will (eventually) contain four rails apps
Only do this step the first time:

```bash
mkdir bog-app-time-trials
cd bog-app-time-trials
```

#### 1. Set up a new Rails project
(Write down your start time!!!)

Create a new Rails project:

```bash
$  rails new bog_app --api -T -d postgresql
$  cd bog_app
$  rails db:create
$  rails s
```

Create your development database:
```bash
$  rails db:create
```

> Watch Out! *If you're not careful, you may already have an existing/old database called bog_app_one or bog_app_two!*

Run your local server:
```bash
$  rails s
```
Your app should be up and running at `localhost:3000`.

> Watch Out! *You may already have a server running on localhost:3000!*

#### 2. Define the `root` and creatures `index` routes

In your text editor, open up `config/routes.rb`. Inside the routes `draw` block, erase all the commented text.

> _You're about to see a hint! Throughout the instructions, there will be hints like this one that show you parts of the code. When you're running through the project a second time, try to use these less. The third time, try not to use them at all._

<details>
  <summary>Hint: <code>config/routes.rb</code> should now look exactly like this...</summary>
  <p>
  
  ```ruby
  #
  # config/routes.rb
  #
  Rails.application.routes.draw do

  end
  ```
  
  </p>
</details>
<br>

Your routes tell your app how to direct **HTTP requests** to **controller actions**. Define your `root` route and your creatures `index` route to refer to the index method in the creatures controller:

<details>
  <summary>Hint: updated routes</summary>
  <p>
  
  ```ruby
  #
  # config/routes.rb
  #

  Rails.application.routes.draw do
    root "creatures#index"

    get "/creatures", to: "creatures#index", as: "creatures"

  end
  ```
  
  </p>
</details>
<br>

In the Terminal, running `rails routes` will list all your routes. You'll see that some routes have a "prefix" listed. These routes have associated route helpers, which are methods Rails creates to generate URLs. The format of a route helper is `prefix_path`. For example, `creatures_path` is the full route helper for `GET /creatures` (the creatures index). We often use route helpers to generate URLs in forms, links, and controllers.

#### 4. Set up the creatures controller and `index` action

Run the following command in the Terminal to generate a controller for creatures:

```bash
$  rails g controller Creatures
```

Next, define the `creatures#index` action in the creatures controller. The variable `@creatures` should be all of the creatures in the db:

<details>
  <summary>Hint: updated controller</summary>
  
  ```ruby
  #
  # app/controllers/creatures_controller.rb
  #
  class CreaturesController < ApplicationController
  # display all creatures
    def index
      # get all creatures from db and save to instance variable
      @creatures = Creature.all
      # render the index view (it has access to instance variable)
      # remember the default behavior is to render :index
      render json: @creatures
    end
  end
  ```
  
</details>




#### 5. Set up the `creature` model

Run the following command in the Terminal to generate the `Creature` model:

```bash
$  rails g model Creature name description
```

Run the migration to update the database with this change:

```bash
$  rails db:migrate
```

> Watch Out! *If you're not careful, you may already have an existing/old database called bog_app_one or bog_app_two, and it may already contain a table called `creatures`!*

#### 6. Create a creature

In the Terminal, enter the Rails console. The Rails console is built on top of `irb`, and it has access to your Rails project. Use it to create a new instance of a creature.  This just lets us confirm that the model class is set up and the migration has run successfully.

```zsh
$  rails c
irb(main):001:0> Creature.create({name: "Yoda", description: "Little green man"})
```

#### 7. Seed your database

When you create an application in development, you typically want some mock data to play with. In Rails, you can just drop this into the `db/seeds.rb` file.

Back in your editor, add some seed data to `db/seeds.rb`:

```ruby

#
# db/seeds.rb
#

Creature.create({name: "Luke", description: "Jedi"})
Creature.create({name: "Darth Vader", description: "Father of Luke"})

```

In the Terminal (not inside rails console!), run `rails db:seed`. Note that the seed file will also run every time you run `rails db:reset` to reset your database.

Use Postman to test your new URL endpoint

## Part II: Make a creature with `new` (form) and `create` (database)


<img src="https://media.giphy.com/media/jnVeAppOL9te0/giphy.gif">

#### 1. Define a route to `create` creatures in the database

Your API needs to be able to post a new creature.  Let's add a `create` action to our routes 

<details>
  <summary> Hint: updated routes</summary>
  <p>

  ```ruby
  #
  #/config/routes.rb
  #

  Rails.application.routes.draw do
    root to: "creatures#index"

    get "/creatures", to: "creatures#index", as: "creatures"
    post "/creatures", to: "creatures#create"

  end
  ```
  
  </p>
</details>

#### 2. Set up the creatures `create` action

The `POST /creatures` maps to the `creatures#create` controller action, so the next step is to define the controller method to handle this request. `creatures#create` should add a new creature to the database.

<details>
  <summary>Hint: pseudocode</summary>
  <p>

  ```ruby
  #
  # app/controllers/creatures_controller.rb
  #

  class CreaturesController < ApplicationController

    # ...

    def create
      # whitelist params
      # create a new creature in the database from the params
      # if creature saves, redirect to route that displays all creatures
    end
  end
  ```
  
  </p>
</details>

<br>
<details>
  <summary>Hint: the code:</summary>
  <p>

  ```ruby
  #
  # app/controllers/creatures_controller.rb
  #

  class CreaturesController < ApplicationController

    # ...

    # create a new creature in the database
    def create
      # whitelist params and save them to a variable
      creature_params = params.require(:creature).permit(:name, :description)

      # create a new creature from `creature_params`
      creature = Creature.new(creature_params)

      # if creature saves, redirect to route that displays all creatures
      if creature.save
        redirect_to creatures_path
        # redirect_to creatures_path is equivalent to:
        # redirect_to "/creatures"
      end
    end
  end
  ```
  
  </p>
</details>

#### 7. Define a route to `show` a specific creature

Right now, your app redirects to `/creatures` after creating a new creature, and the new creature shows up at the bottom of the page. Let's make a route for users to see a specific creature. Then, you'll be able to show a new creature by itself right after it's created.

First, define a `show` route.

<details>
  <summary>Hint: updated routes</summary>
  <p>
  
  ```ruby
  #
  # config/routes.rb
  #

  Rails.application.routes.draw do
    root to: "creatures#index"

    get "/creatures", to: "creatures#index", as: "creatures"
    post "/creatures", to: "creatures#create"
    get "/creatures/:id", to: "creatures#show", as: "creature"
  end
  ```
  
  </p>
</details>

Now that you have your `show` route, set up the controller action for `creatures#show`.

<details>
  <summary>Hint: updated controller</summary>
  <p>

  ```ruby
  #
  # app/controllers/creatures_controller.rb
  #

  class CreaturesController < ApplicationController

    ...

    # display a specific creature
    def show
      # get the creature id from the url params
      creature_id = params[:id]

      # use `creature_id` to find the creature in the database
      # and save it to an instance variable
      @creature = Creature.find_by_id(creature_id)

      # render the show view (it has access to instance variable)
      # remember the default behavior is to render :show
      render json: @creature
    end

  end
  ```
  
  </p>
</details>

## Part III: Change a creature with `edit` (form) and `update` (database)

<img src="https://aos.iacpublishinglabs.com/question/aq/700px-394px/how-long-is-a-caterpillar-in-a-cocoon_095bed7c-a98c-486d-b938-48e0b7ce39f2.jpg?domain=cx.aos.ask.com" width="70%">

<!-- ![](https://camo.githubusercontent.com/9f3f575f52088b41954636a670b1d44b3eac9fb9/687474703a2f2f692e67697068792e636f6d2f31324b7856766a35415232556e652e676966)   -->

**Don't Give Up!!!**

`update` changes the creature info in the database when the user submits the form

#### 4. Define a route to `update` a specific creature

The update route will use the `id` of the creature to be updated. In Express, you decided between `PUT /creatures/:id` and `PATCH /creatures/:id`, depending on the type of update you wanted to do. In Rails, the default assumption is that you'll have both! However, we'll only **need** to add `PATCH /creatures/:id` to our routes.

<details>
  <summary>Hint: updated routes</summary>
  <p>
  
  ```ruby
  #
  # config/routes.rb
  #

  Rails.application.routes.draw do
    root to: "creatures#index"

    get "/creatures", to: "creatures#index", as: "creatures"
    post "/creatures", to: "creatures#create"
    get "/creatures/:id", to: "creatures#show", as: "creature"
    patch "/creatures/:id", to: "creatures#update"
    # put "/creatures/:id", to: "creatures#update"    # optional
  end
  ```
  
  </p>
</details>

Run `rails routes` in the Terminal to see the newly created update routes.

#### 5. Set up the creatures `update` action

In the `CreaturesController`, define an `update` method:

<details>
  <summary>Hint: pseudocode</summary>
  <p>

  ```ruby
  #
  # app/controllers/creatures_controller.rb
  #

  class CreaturesController < ApplicationController

    ...

    # update a creature in the database
    def update
      # get the creature id from the url params
      # use `creature_id` to find the creature in the database and save to variable
      # whitelist params 
      # update the creature based on params
      # redirect to show page for the updated creature
    end

  end
  ```
  
  </p>
</details>
<br>


<details>
  <summary>Hint: code</summary>
  <p>

  ```ruby
  #
  # app/controllers/creatures_controller.rb
  #

  class CreaturesController < ApplicationController

    ...

    # update a creature in the database
    def update
      # get the creature id from the url params
      creature_id = params[:id]

      # use `creature_id` to find the creature in the database
      @creature = Creature.find_by_id(creature_id)

      # whitelist params and save them to a variable
      creature_params = params.require(:creature).permit(:name, :description)

      # update the creature
      @creature.update_attributes(creature_params)

      render json: @creature
    end

  end
  ```
  
  </p>
</details>

#### 6. Refactor whitelisted `params`.

Now that `params` are whitelisted in two different places in the `CreaturesController`, refactor so that these params are set up in their own method.   This method can (and should!) be `private` because it will only ever be used inside the `CreaturesController` class definition.


<details>
  <summary>Hint: pseudocode</summary>
  <p>

  ```ruby
  #
  # app/controllers/creatures_controller.rb
  #

  class CreaturesController < ApplicationController

    ...

    # update a creature in the database
    def update
      # get the creature id from the url params
      # use `creature_id` to find the creature in the database
        # and save it to an instance variable
      # update the creature based on whitelisted params returned by private method
      # redirect to show page for the updated creature
    end
    
    private
    
    def creature_params
      # whitelist params return whitelisted version
    end

  end
  ```
  </p>
</details>
<br>

<details>
  <summary>Hint: code</summary>
  <p>

  ```ruby
  #
  # app/controllers/creatures_controller.rb
  #

  class CreaturesController < ApplicationController

    ...

    # update a creature in the database
    def update
      # get the creature id from the url params
      creature_id = params[:id]

      # use `creature_id` to find the creature in the database
      # and save it to an instance variable
      @creature = Creature.find_by_id(creature_id)

      # update the creature
      @creature.update_attributes(creature_params)  # this now calls the private method below!

      render json: @creature
    end
    
    private
    
    def creature_params
      # whitelist params return whitelisted version
      params.require(:creature).permit(:name, :description) 
    end

  end
  ```
  </p>
</details>

**Refactor the `create` action to use this private method as well.**


Manually re-test your `creatures#create` method in Postman. Then, test your `creatures#update` method in the Postman by editing the creature with an `id` of 1. Then, `git add` and `git commit` your work.

## Part IV: Delete a creature with `destroy` (database)


![](https://www.geek.com/wp-content/uploads/2016/03/bigfoot-625x440.jpg)

<!-- ![](https://camo.githubusercontent.com/f0e4aa6a005ce35a3777c33d2445b3396be690f0/687474703a2f2f692e67697068792e636f6d2f6e53556e4f4c4a46324e6776362e676966) -->

#### 1. Define a route to `destroy` a specific creature

Following a similar pattern to our other routes, create a route to `destroy` (delete) a specific creature based on its `id`.

<details>
  <summary>Hint: updated routes</summary>
  <p>

  ```ruby
  #
  # config/routes.rb
  #

  Rails.application.routes.draw do
    root to: "creatures#index"

    get "/creatures", to: "creatures#index", as: "creatures"
    post "/creatures", to: "creatures#create"
    get "/creatures/:id", to: "creatures#show", as: "creature"
    patch "/creatures/:id", to: "creatures#update"
    delete "/creatures/:id", to: "creatures#destroy"
  end
  ```
  
  </p>
</details>

At this point, you're using all the required RESTful routes for creatures (feel free to add optional PUT).


#### 2. Set up the creatures `destroy` action

In the `CreaturesController`, define an `destroy` method:

<details>
  <summary>Hint: pseudocode</summary>
  <p>
  
  ```ruby
  #
  # app/controllers/creatures_controller.rb
  #

  class CreaturesController < ApplicationController

    ...

    # delete a creature from the database
    def destroy
      # get the creature id from the url params
      # use `creature_id` to find the creature in the database and save it to a variable
      # destroy the creature
      # redirect to creatures index
    end

  end
  ```
  
  </p>
</details>
<br>
<details>
  <summary>Hint: code</summary>
  <p>
  
  ```ruby
  #
  # app/controllers/creatures_controller.rb
  #

  class CreaturesController < ApplicationController

    ...

    # delete a creature from the database
    def destroy
      # get the creature id from the url params
      creature_id = params[:id]

      # use `creature_id` to find the creature in the database
      # and save it to a variable
      creature = Creature.find_by_id(creature_id)

      # destroy the creature
      creature.destroy

      render json: {
        msg: "Successfully Deleted"
      }
    end

  end
  ```
  
  </p>
</details>


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

In your `app.js`, make sure you add the Express static middleware and you change your `app.get('/')` to handle the built React app.

```js
// app.js
...
  app.use(express.static(`${__dirname}/client/build`))
...
  app.get('/', (req, res) => {
    res.sendFile(`${__dirname}/client/build/index.html`)
  })
...
```

Also make sure to add a postinstall and dev step to the root package.json to help Heroku know how to deploy your app.

```json
 "engines": {
   "node": 8.9.0
 },
 "scripts": {
    "start": "node app.js",
    "dev": "concurrently \"node app.js\" \"cd client && npm start\"",
    "test": "echo \"Error: no test specified\" && exit 1",
    "postinstall": "cd client && npm i && npm run build"
  },
```

You should now be able to run both your API and React app by using the command `npm run dev`

**ASIDE**: This is a great opportunity to deploy to Heroku!
Make sure you follow these commands.
```bash
  heroku create
  heroku addons:create mongolab:sandbox
  git push heroku master

  # If you need to seed your production database
  heroku run node db/seeds.js
```

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
Use the `Creatures` component to house components that allow you do the following:
 - Get All Creatures and display them as a list of `Link`s.
 - Click a button to toggle a form on and off.
 - Input data into a form to create a new creature.

Take a look at the [solution code](./express_bog/client/src) for hints

#### 8. Read One, Update, and Delete
Use the `SingleCreature` component to house components that allow you to get one creature, toggle a form to update the creature, and delete a creature
Take a look at the [solution code](./express_bog/client/src) for hints

#### 9. Introduce Styled Components
Once you have the usability for creatures, use styled components to style your application.
Keep these things in mind.  Feel free to also bring in libraries like `material-ui`

- Does my app look good on mobile?
- Can I add transitions and animations to this UI
- Does this app look professional and polished?

## Additional Development Ideas for after Version 4

* Add links to other pages to help users navigate your site. For instance, a creature show page might have a link to the creatures index page. Use `link_to`.  Also link each creature on `creatures#index` to its individual `show` page.
* If you'd like, add a `navbar` with links to the homepage (`/`) and the new creatures page (`/creatures/new`). This navbar should show up on every page. Take advantage of whichever CSS library you chose to include!
* Read about [Active Record Validations](http://guides.rubyonrails.org/active_record_validations.html), and add validations to the `Creature` model to make sure a new creature can't be created without a `name` and `description`.
* Read the docs for the [Paperclip gem](https://github.com/thoughtbot/paperclip), and incorporate it into your Bog App to upload photos of creatures locally.


## CONGRATULATIONS! You have created a Bog App! Take a break, you look *Swamped*!

![](https://cloud.githubusercontent.com/assets/7833470/11501240/83536030-97e7-11e5-8060-fa7666de7165.jpeg)

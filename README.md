# connect-four-rails-vue
The game Connect Four written in Rails and Vue

# Prerequisites
* Node
* Yarn
* PostgreSQL

# Setup
Run `bundle` and then `yarn`.

# Run Locally
Run `rails s`.

# Test
Run `yarn test` and `bundle exec rspec`.

# Heroku
Run
`heroku buildpacks:add heroku/nodejs
`heroku buildpacks:add heroku/ruby
`heroku buildpacks:add https://github.com/dmathieu/heroku-buildpack-submodules`.

This app is live on Heroku: https://connect-four-rails-vue.herokuapp.com/

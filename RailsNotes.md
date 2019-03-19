Routes are in `routes.rb` in a config folder  

`rails --version` need 5.1.6

`rails new <applicationName> -T -d="postgresql" --skip-spring --skip-turbolinks`
  -T (no minitest)
  -d (database)
  -spring (reloader)
  -turbolinks (use JS to reload fragments)

`rails g rspec:install` or `rails generate rspec:install`

features folder in rspec all tests end with `_spec.rb`

first line of tests `require 'rails_helper'`

`setup, exercise, Assert Teardown` for tests

rails generation for migrations

`rails g migration CreateSongs title:string length:integer play_count:integer`

In Routes `get '/route', to: 'controller#method'`
`resources :<controller>, only: [<desired routes>]`

Controllers -- `<model>s_controller.rb` -- pluralize model applicationName

views must match method names inside folder that is named after resource/Controllers

`rails server` or `rails s`

`rails console` or `rails c` instead of tux

`raisl g migration AddArtistToSongs artist:references`

Can put `!` on create for testing

`has_many :playlist_songs`
`has_many :songs, through: :playlist_songs`

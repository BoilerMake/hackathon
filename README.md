Hackathon
========

This is the internal tool that Boilermake uses to manage various things around its hackathon.

Currently under active development and in use in production at [boilermake.org](BoilerMake)

## Features
- User Auth
  - Email Confirmations
  - password reset
  - remember me
- Teams
  - Join
  - Leave
  - limit size
- Applications

## Dev Setup
```bash
git clone git@github.com:BoilerMake/hackathon.git
cd hackathon
bundle install
rake db:migrate
rake addSchools
rails s
```

You should now be able to navigate to (http://localhost:3000) and see the welcome page.


## Super quick intro to rails/this app

Check out `config/routes.rb` to see how routing works.
`root pages#welcome`
The root loads the `pages` controller with action `welcome`.
The pages controller is a dedicated controller for static pages, such as the
welcome page. You can see the it does load two instance variables for the view to use.

These are leftover from the last boilermake site, but they're relevant so I left them in.

To see what actually gets rendered, you need to remember that every page goes through a layout first.

In this case, it inherits the global layout found at `app/views/layouts/application_layout.html.haml`.

At the end of this file you see `yield`.
`yield` is a bit tricky, so I'll let you read about it on your [own](http://stackoverflow.com/questions/3066703/blocks-and-yields-in-ruby),
but the gist of it is that it passes rendering along to the specific view, which is at
`app/views/pages/welcome.html.haml`



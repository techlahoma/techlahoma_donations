# Techlahoma Donations

## Prerequisites

You will need the following things properly installed on your computer.

* ruby - Check the `Gemfile` for the version required
* postgres


## Project Dependencies

To access the admin area you will need the following related projects installed and running on
your computer.

* [techlahoma/techlahoma](https://github.com/techlahoma/techlahoma)

## Rails setup
```
> git clone https://github.com/techlahoma/techlahoma_donations.git
> cd techlahoma_donations
> bundle install
```

## Database setup

Make sure that postgress is running locally and then run:

```
> rake db:create
> rake db:migrate
```

## Configuration

This app relies on several environment variables being set. You should copy the
`dotenv.sample.env` file to `.env` and update the values there as
needed. The default values should get you going with a complete local
setup.

If you're going to test any Stripe related features you'll want to create your own development
account there in order to see exactly what's happening. When you do that
make sure to update your `.env` file accordingly.

After you've configured Stripe in your local `.env`, you need to create
some subscription plans there so that the subscription forms will work.

```
rake donations:stripe_plans:create_all
```

If you're making changes to the plan structure and need to start over
you can delete all the subscription plans in the connected Stripe
account by running:

```
rake donations:stripe_plans:delete_all
```

## Auth Configuration

Go to the /oauth/applications endpoint on the Techlahoma installation that you want to integrate with.
For development this will probably be http://localhost:3000/oauth/applications.

Create a new application, and set the callback URL to http://localhost:5001/auth/techlahoma/callback.
Change the port if you plan to run this app on a different port.

After creating the app copy the Application ID and Secret into your `.env` file.

## Running tests

The RSpec based unit tests can be run with:

```
> rspec
```

And the Cucumber based integration tests can be run with:

```
> cucumber
```

## Starting the rails server
```
> foreman start
```

## Running a rails console
```
> rails c
```

## Deployment

Deployment happens automatically through [WE_NEED_A_CI_SERVICE]. Any pushes to `master` will be deployed. **This isn't actually true yet.**
This is deployed on heroku, and currently is deployed through direct pushing.



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

## SSL

This page desdribes the process for obtaining and installing a cert from
Let's Encrypt.

http://collectiveidea.com/blog/archives/2016/01/12/lets-encrypt-with-a-rails-app-on-heroku/

tl,dr:

```
$ brew install certbot
...
$ sudo certbot certonly --manual
```

You'll be prompted to enter an email address. Use: `techlahoma@gmail.com`

You'll be prompted to enter a domain. Use: `donate.techlahoma.org`

At this point, in your terminal you should see something like:

```
Make sure your web server displays the following content at

http://donate.techlahoma.org/.well-known/acme-challenge/xyz before continuing:

xyz.abc
```

Copy the content that should be displayed (in this case `xyz.abc`), and
then update `app/controllers/letsencrypt_controller.rb` with that new
value. Commit the change and deploy the app to heroku (`git push heroku
master`).

Once the updated challenge has been deployed, you can press ENTER in the
certbot terminal to continue.

If everything went smoothly you should see something like:

```
IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at
   /etc/letsencrypt/live/donate.techlahoma.org/fullchain.pem. Your
   cert will expire on 2017-02-05. To obtain a new or tweaked version
   of this certificate in the future, simply run certbot again. To
   non-interactively renew *all* of your certificates, run "certbot
   renew"
```

At this point you should have a cert and key file in `/etc/letsencrypt/archive/donate.techlahoma.org`.

You only need `fullchain1.pem` and `privkey1.pem`.

To update the certs at heroku you can use a command like this:

`heroku certs:update fullchain1.pem privkey1.pem`

You can use a full path to each file if they don't live in your current
directory.


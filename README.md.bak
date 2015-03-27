# Clio In/Out Board skeleton

Feel free to add to the `Gemfile` any gems that you find helpful.

## Environment Requirements

The app must run on:

- Ruby 2.1.4
- Rails 3.2.*
- sqlite3

## Features to Add

### Asynchronous updates

The statuses in the UI should update asynchronously, in close to realtime,
without having to refresh the page or click the update link.

### Teams

The app should be able to support teams of users (such as Customer Service
Reps, Salespeople) so that people on a team can better track the people
they work with.

A user can only belong to a single team. The following functionality should
be present:

  * Create a team
  * Delete a team
  * Change a team's name
  * Add & remove people from teams

### Tests

Ensure that the app has good test coverage using RSpec. Your tests should
produce a reasonable test coverage report. (Use `COVERAGE=true bundle exec
rspec` to generate the coverage report; the report is located at
`coverage/index.html`.)

### Migration for IP addresses

There is a branch in this project (`integer-ips-for-users`) which contains
code to convert the `current_sign_in_ip` and `last_sign_in_ip` columns on
the User table from strings to integers. Merge it into your code.

This branch contains a migration
(`20130416230652_convert_string_ips_to_integers.rb`) which, when run, will
destroy any existing data in those columns. Alter this migration to ensure
that, if the database was full of data before the migration, all data would
still be intact afterwards.

## Additional Questions to Answer

Please include your answers in a text file with the project.

1. Notice that, in the finished project, the IP addresses are stored as
integers in the DB. What are the pros and cons of this approach, compared
to storing the IP addresses as strings?

2. Are there any security issues present in the app itself? (No need to
mention security vulnerabilities within external gems.) List any security
issues you found, and how to fix them. Also list any potential security
issues that you investigated which you believe the site to be free of.

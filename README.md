# Clio In/Out Board skeleton

## Instructions
- Run `bundle install` to install latest Gemfile.lock
- Create DB: `rake db:setup`
- Run: `rails s`
- To run RSpec and create a coverage report you might need to run `rake db:test:prepare` beforehand 

## README

### General
- Bundle updated
- Bootstrap 3 used as CSS framework
- React used as frontend javascript framework (includes JSX precompiler)
- Turbolinks added

### Asynchronous Updates
- Implemented with recursive setTimeout loop (`/app/assets/javascripts/components/[users.js.jsx.cofee, teams.js.jsx.coffee]`) (set to update every 1+(RTT) second)
- Updates to DOM are handled using the React library

### Teams
- Team scaffolds added.
- `User` maintains relationship to `Team` via `team_id` as a user can only belong to one team.

### Tests
- General behavior tests added
- 100% coverage

### Migration for IP Addresses
- `integer-ips-for-users` branch merged to `master`.
- Data retained during migration via loading all `User` records into `users` variable before doing the column change. After the column change, `users` is iterated over and `current_sign_in_ip` and `last_sign_in_ip` are re-set using their old values by accessing them as hashes (therefore bypassing the overwritten getters in `User`) and saved.  

## Questions

### 1. Integer IP Storage

#### Pros
- Better database level performance.
- Takes less space than chars/varchar
- Faster lookups (int comparison is faster than string)
- Faster sorting (again, int comparison is faster)

#### Cons
- Lookup by IP with just ActiveRecord is impossible without changing the target IP to an integer before hand (ie. `User.where(current_sign_in_ip: '192.168.0.1')` is impossible)
- Extra overhead on application level
- Database is now reliant on application level functionality to be read properly.  If any other application wants to access the DB, it will have to share the same conversion functionality.

### 2. Security Issues
- Nothing immediately stands out

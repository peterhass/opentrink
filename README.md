# Dev setup

App has no external dependencies

```bash
rvm use # or similar: check .ruby-version
bundle install
rake db:setup db:seed # Note printed Invitation ID
./bin/dev

# Visit http://localhost:3000/invitations/<InvitationId>/users/new to login
```

# Deploy

```bash
# on local machine
podman-compose build && podman-compose push

# on prod machine
machinectl shell --uid opentrink
systemctl --user restart opentrink
```

# TODO
- REGENERATE MASTER KEY, put it in gitignore
- Prod: Include database in backup
- Need some functionality to verify a user on the scoreboard 
- Put some kind of ttl on user consumption links to prevent people from using other participants QR codes

# IDEAS / NOTES
- "Don't roll your own auth"
- Let users choose any name and always display them with a unique set of emojis based on their id
- Scoreboard: 
    - Show beer consumption per hour
    - Show trend (like with stocks)
    - Animation when order changes
    - Overlay for major changes in the list (like bowling text animations)
    - Rotating display
- Let users create groups between themselves to contribute to the group ranking
- How to improve the process of tracking multiple consumptions one after another
- User management
    - Invitation based system
    - Admin can create new Invitation
    - Every Invitation has an unique token 
        https://fullstackheroes.com/tutorials/rails/sorcery-passwordless-authentication/
    - Given you're not authenticated and you visit an invitation link, a new user is created (username = Orderman123, pw = garbage) and immediately logged in
    - Invitation admin page shows which users are created using which Invitation
    - Invitations can be deactivated
    - Users can be deactivated
    - Consumptions are associated with Users to be able to clean up data in worst case
- Split up hosts between read-only and write-only

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

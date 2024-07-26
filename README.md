Opentrink powers Fleischerei Pfandl's drinking contest.

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


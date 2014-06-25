# GDS Missions

This is a work-in-progress hack to create an index of "missions" at GDS (along
with their mission patches).

## Quick start in development

    $ createuser -S missions
    $ createdb -O missions missions_development

    $ bundle install

    $ rake db:create db:migrate
    $ unicorn -p 5000

# Licence

MIT Licence

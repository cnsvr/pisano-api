#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

rake db:create
rake db:migrate
rake db:migrate RAILS_ENV=test
rake db:seed
rake rswag:specs:swaggerize

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
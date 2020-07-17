# Llerena
server '51.254.129.78', user: 'deploy', roles: %w{app db web}

set :stage, :staging
set :rails_env, "staging"

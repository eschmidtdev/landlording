# Creates a output log for you to view previously run cron jobs
set :output, 'log/cron.log'

# Sets the environment to run during development mode (Set to production by default)
set :environment, 'development'

env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']

every 8.hours do
  runner 'Token.create_access_token'
end
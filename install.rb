# Sprinkle deployment script

# Setup code
#  Code to run on the local system before Sprinkle.

#  This gets the name of the target system from the command-line
TARGET = ARGV.first

# The email address for system messages and reports
ADMIN_EMAIL = ARGV[1] || 'root@localhost'

# The name of the user account on the remote system, default to "deploy"
ACCOUNT = ARGV[2] || 'deploy'

# Recipe list, default to "minimal"
RECIPES = ARGV[3..-1]
RECIPES << 'minimal' if RECIPES.empty?

# require_relative doesn't work in this context
RECIPES.each do |recipe|
  require File.join(File.dirname(__FILE__), 'recipes', recipe)
end

# Sprinkle Deployment
#  Defines script wide settings,
#  such as a delivery mechanism for executing commands on the target
#  system (eg. Capistrano), and installer defaults (eg. build locations, etc).

deployment do

  delivery :capistrano do

    # Use Capistrano options in Capfile
    recipes 'Capfile'

    set :user, ACCOUNT
    role :app, TARGET

  end

end
ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.

# Debug output for Gitpod
puts "===== DEBUG OUTPUT ====="
puts "GITPOD_WORKSPACE_ID: #{ENV['GITPOD_WORKSPACE_ID']}"
puts "GITPOD_WORKSPACE_URL: #{ENV['GITPOD_WORKSPACE_URL']}"
puts "HOSTNAME: #{ENV['HOSTNAME']}"
puts "======================="

# This initializer runs early in the boot sequence to disable host authorization
puts "Starting initializer: 0_disable_host_authorization.rb"

if Rails.env.development?
  begin
    # Try to disable the middleware by removing it from the middleware stack
    Rails.application.config.middleware.delete ActionDispatch::HostAuthorization
    puts "Successfully disabled ActionDispatch::HostAuthorization for development environment"
  rescue => e
    puts "Warning: Could not disable ActionDispatch::HostAuthorization: #{e.message}"
  end
  
  # Add the Gitpod host explicitly
  gitpod_host = "3000-slucha-rpggame-k76dclncl0c.ws-eu118.gitpod.io"
  Rails.application.config.hosts << gitpod_host if Rails.application.config.respond_to?(:hosts)
  puts "Added Gitpod host to allowed hosts list: #{gitpod_host}"
  
  # As a fallback, completely clear the hosts list
  Rails.application.config.hosts.clear if Rails.application.config.respond_to?(:hosts)
  puts "Cleared hosts list as a fallback"
end 
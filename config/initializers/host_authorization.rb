# Disable ActionDispatch::HostAuthorization in development environment
if Rails.env.development?
  Rails.application.config.middleware.delete ActionDispatch::HostAuthorization
  puts "Disabled ActionDispatch::HostAuthorization for development environment"
end 
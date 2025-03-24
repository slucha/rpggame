# Check for DISABLE_HOST_CHECK environment variable
if ENV['DISABLE_HOST_CHECK'] == 'true'
  puts "DISABLE_HOST_CHECK environment variable detected - disabling host checking"
  Rails.application.config.hosts.clear if Rails.application.config.respond_to?(:hosts)
end 
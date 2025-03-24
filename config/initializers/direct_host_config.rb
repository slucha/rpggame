# Direct host configuration for Rails
# In development mode, allow all hosts by setting config.hosts = nil
if Rails.env.development?
  puts "Disabling host checking in development mode"
  Rails.application.config.hosts = nil
end 
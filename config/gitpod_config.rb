# Gitpod-specific configuration
if ENV['GITPOD_WORKSPACE_ID'].present?
  puts "Configuring for Gitpod environment..."
  
  # Extract Gitpod workspace details
  workspace_id = ENV['GITPOD_WORKSPACE_ID']
  workspace_url = ENV['GITPOD_WORKSPACE_URL']
  workspace_host = ENV['HOSTNAME']
  
  puts "Workspace ID: #{workspace_id}"
  puts "Workspace URL: #{workspace_url}"
  puts "Hostname: #{workspace_host}"
  
  # Since we're disabling host checking in development mode (setting hosts to nil),
  # we don't need to add specific hosts. Just log the information.
  if workspace_url
    domain_parts = workspace_url.match(/https:\/\/([^\/]+)/)
    if domain_parts && domain_parts[1]
      gitpod_domain = domain_parts[1].sub(/^\d+-/, '')
      puts "Detected Gitpod domain: #{gitpod_domain}"
      puts "Host checking is disabled in development mode, so no need to add specific hosts."
    end
  end
  
  puts "Current hosts configuration: #{Rails.application.config.hosts.inspect}"
end 
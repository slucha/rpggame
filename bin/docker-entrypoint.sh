#!/bin/bash
set -e

# Create a temporary patcher script
cat > /tmp/patch_config.rb << 'EOF'
filename = "/app/config/environments/development.rb"
content = File.read(filename)

# Add this line after the 'config.hosts << "localhost"' line
if !content.include?("config.hosts.clear") && content.include?("config.hosts <<")
  content = content.gsub(/(config\.hosts << .*$)/, "\\1\n  # Completely disable host authorization for Gitpod\n  config.hosts.clear")
  File.write(filename, content)
  puts "Modified #{filename} to disable host checking"
else
  puts "File #{filename} already modified or doesn't contain expected pattern"
end
EOF

# Run the patcher
ruby /tmp/patch_config.rb

# Continue with normal startup
exec "$@" 
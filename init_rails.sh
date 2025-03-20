#!/bin/bash
set -e

# This script generates a new Rails app if it doesn't exist yet

# Check if Rails is already installed
if [ ! -f "config/routes.rb" ]; then
  echo "======== Creating new Rails application ========"
  # Install Rails if not present
  gem install rails
  
  # Create a new Rails app with PostgreSQL
  rails new . --database=postgresql --skip-git --skip-bundle
  
  # Copy our pre-configured database.yml
  cp -f config/database.yml.backup config/database.yml 2>/dev/null || true
  
  # Install all dependencies
  bundle install
  
  # Set up the database
  rails db:create
  rails db:migrate
  
  echo "======== Rails application created successfully ========"
else
  echo "======== Rails application already exists ========"
fi 
class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  # Bypass host checking in development environment
  before_action :bypass_host_check

  private

  def bypass_host_check
    # This is a workaround for Gitpod host blocking
    if Rails.env.development?
      host = request.host
      Rails.application.config.hosts << host if Rails.application.config.respond_to?(:hosts) && !Rails.application.config.hosts.include?(host)
    end
  end
end

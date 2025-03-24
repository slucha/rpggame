module Api
  class StatusController < ApplicationController
    def index
      render json: { 
        message: "Hello from Legends of Runeterra Clone!", 
        status: "OK",
        environment: Rails.env,
        gitpod_workspace_id: ENV['GITPOD_WORKSPACE_ID'],
        hostname: ENV['HOSTNAME'],
        time: Time.now
      }
    end
  end
end 
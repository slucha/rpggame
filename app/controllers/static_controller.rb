class StaticController < ActionController::Base
  # Skip any Rails filters or middleware that might be interfering
  skip_before_action :verify_authenticity_token, if: :method_defined?(:verify_authenticity_token)
  
  def index
    # Force content type to be HTML
    response.headers['Content-Type'] = 'text/html'
    
    # Render the static HTML directly as a string
    render html: <<-HTML.html_safe
      <!DOCTYPE html>
      <html>
        <head>
          <title>Legends of Runeterra Clone</title>
          <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        </head>
        <body style="background-color: #282c34; color: white; font-family: Arial, sans-serif; text-align: center; padding-top: 100px;">
          <h1>Legends of Runeterra Clone</h1>
          <p>This is a static HTML page served directly from the controller.</p>
          
          <div style="margin-top: 30px;">
            <a href="/static/game" style="display: inline-block; padding: 10px 20px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px;">Play Game</a>
          </div>
        </body>
      </html>
    HTML
  end
  
  def game
    # Force content type to be HTML
    response.headers['Content-Type'] = 'text/html'
    
    # Render the static HTML directly as a string
    render html: <<-HTML.html_safe
      <!DOCTYPE html>
      <html>
        <head>
          <title>Game - Legends of Runeterra Clone</title>
          <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        </head>
        <body style="background-color: #282c34; color: white; font-family: Arial, sans-serif; text-align: center; padding-top: 100px;">
          <h1>Game Page</h1>
          <p>This is the game page served directly from the controller.</p>
          
          <div style="margin-top: 30px;">
            <a href="/static" style="display: inline-block; padding: 10px 20px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px;">Home</a>
          </div>
        </body>
      </html>
    HTML
  end
end 
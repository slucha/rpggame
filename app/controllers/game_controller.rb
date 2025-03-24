class GameController < ApplicationController
  layout false  # Disable the default application layout
  
  def index
    # Force the content type to be HTML
    response.headers['Content-Type'] = 'text/html'
    
    # Render the static HTML file
    respond_to do |format|
      format.html { render file: Rails.root.join('public', 'game', 'index.html'), layout: false }
      format.all { render file: Rails.root.join('public', 'game', 'index.html'), layout: false }
    end
  end
end 
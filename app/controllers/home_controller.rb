class HomeController < ApplicationController
  # This controller serves the main game UI
  layout false  # This disables the default application layout
  
  def index
    # Force the content type to be HTML
    response.headers['Content-Type'] = 'text/html'
    
    # Explicitly render the index template (HTML)
    respond_to do |format|
      format.html { render :index }
      format.all { render :index }
    end
  end
end 
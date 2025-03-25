class HtmlGameController < ApplicationController
  layout false

  def index
    render html: '', layout: false
  end

  def standalone
    # Force the content type to be HTML
    response.headers['Content-Type'] = 'text/html'
    
    # Render the standalone HTML file
    render file: Rails.root.join('public', 'standalone.html')
  end
end 
class HtmlGameController < ActionController::Base
  layout false

  def index
    render file: Rails.root.join('app/views/game/index.html.erb')
  end
end 
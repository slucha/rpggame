module Api
  class CardsController < ApplicationController
    # Return all cards in JSON format
    def index
      cards = Card.all
      render json: cards
    end
  end
end 
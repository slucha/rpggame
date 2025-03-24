module Api
  class GameController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    # Start a new game
    def start
      game_state = {
        turn: 'player',
        player: {
          health: 20,
          hand: generate_cards(5),
          board: [],
          deck: generate_cards(20)
        },
        bot: {
          health: 20,
          hand: Array.new(5) { {} },
          board: [],
          deck: Array.new(20) { {} }
        }
      }
      
      render json: game_state
    end
    
    # Handle player moves
    def move
      action = params[:action_type] || params[:action]
      
      # This would be replaced with actual game logic and persistent game state
      # For MVP, we'll just simulate responses
      
      # Simulate the response based on the action
      case action
      when 'play_card'
        response = simulate_play_card(params[:card_index])
      when 'attack'
        response = simulate_attack(params[:attacker_index], params[:target_index])
      when 'end_turn'
        response = simulate_bot_turn
      else
        return render json: { error: 'Invalid action' }, status: 400
      end
      
      render json: response
    end
    
    private
    
    # Generate random cards for the game
    def generate_cards(count)
      card_types = [
        { name: 'Knight', attack: 3, defense: 3, image_url: '/assets/cards/knight.jpg' },
        { name: 'Archer', attack: 2, defense: 1, image_url: '/assets/cards/archer.jpg' },
        { name: 'Mage', attack: 4, defense: 2, image_url: '/assets/cards/mage.jpg' },
        { name: 'Dragon', attack: 5, defense: 5, image_url: '/assets/cards/dragon.jpg' },
        { name: 'Golem', attack: 2, defense: 6, image_url: '/assets/cards/golem.jpg' }
      ]
      
      cards = []
      count.times do
        card_type = card_types.sample
        cards << card_type.dup
      end
      
      cards
    end
    
    # Simulate playing a card
    def simulate_play_card(card_index)
      # For MVP, we'll just create a simple response
      player_hand = generate_cards(4) # Simulating the remaining cards in hand
      player_board = generate_cards(rand(1..3)) # Simulating cards on the board
      
      {
        turn: 'player',
        player: {
          health: 20,
          hand: player_hand,
          board: player_board,
          deck: Array.new(15) { {} } # Simulating remaining deck
        },
        bot: {
          health: 20,
          hand: Array.new(5) { {} },
          board: generate_cards(rand(0..2)), # Bot might have some cards on board
          deck: Array.new(18) { {} }
        }
      }
    end
    
    # Simulate attack action
    def simulate_attack(attacker_index, target_index)
      # For MVP, we'll just create a simple response
      {
        turn: 'player',
        player: {
          health: 20,
          hand: generate_cards(4),
          board: generate_cards(rand(1..3)),
          deck: Array.new(15) { {} }
        },
        bot: {
          health: 18, # Bot got hit
          hand: Array.new(5) { {} },
          board: generate_cards(rand(0..2)),
          deck: Array.new(18) { {} }
        }
      }
    end
    
    # Simulate bot's turn
    def simulate_bot_turn
      # For MVP, we'll just create a simple response after bot's actions
      {
        turn: 'player', # Turn goes back to player
        player: {
          health: 18, # Player got hit
          hand: generate_cards(5), # Player draws a card
          board: generate_cards(rand(1..3)),
          deck: Array.new(14) { {} }
        },
        bot: {
          health: 20,
          hand: Array.new(4) { {} }, # Bot played a card
          board: generate_cards(rand(1..3)), # Bot has some cards on board
          deck: Array.new(17) { {} }
        }
      }
    end
  end
end 
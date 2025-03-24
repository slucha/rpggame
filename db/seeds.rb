# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code should be idempotent so that it can be executed at any point in every environment.
# To run: bin/rails db:seed

# Clear existing cards
Card.destroy_all

# Define some abilities for variety
abilities = [
  "Deal 1 damage to all enemy units",
  "Heal your Nexus for 2",
  "Give an ally +1/+1 until end of turn",
  "When I'm summoned, draw a card",
  "When I'm summoned, deal 1 damage to the enemy Nexus",
  "When I attack, give me +2/+0 until end of turn",
  "When I survive damage, grant me +1/+1",
  "When I'm summoned, create a random card in hand",
  "When I strike, draw a card",
  "When an ally is summoned, give it +0/+1 this round",
  "Barrier: Prevent the next damage I would take",
  "Quick Attack: I strike before my opponent when attacking",
  "Elusive: I can only be blocked by elusive units",
  "Tough: I take 1 less damage from all sources",
  "Regeneration: Fully heal me at the start of each round"
]

# Elements for card theming
elements = ["Fire", "Water", "Earth", "Air", "Light", "Dark", "Thunder", "Ice", "Nature", "Cosmic"]
types = ["Warrior", "Mage", "Archer", "Knight", "Assassin", "Summoner", "Beast", "Dragon", "Spirit", "Guardian"]

# Generate random cards
puts "Creating 100 cards..."

100.times do |i|
  element = elements.sample
  type = types.sample
  attack = rand(0..10)
  defense = rand(1..10)
  ability = abilities.sample
  
  Card.create!(
    name: "#{element} #{type} #{i+1}",
    attack: attack,
    defense: defense,
    ability: ability,
    image_url: "https://placehold.co/200x300/#{rand(111111..999999)}/FFFFFF?text=#{element}+#{type}"
  )
end

puts "Cards created successfully!"

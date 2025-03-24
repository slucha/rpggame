# Legends of Runeterra Clone

A simplified card game inspired by Legends of Runeterra, featuring 3D elements with Three.js.

## How to Run the Game

### Option 1: Open the Standalone HTML File Directly

The simplest way to run the game is to download and open the standalone HTML file:

1. Download the `public/standalone.html` file to your computer
2. Open it directly in a modern web browser (Chrome, Firefox, Edge)
3. No server or installation is required!

### Option 2: Using the Express Server

```bash
# Install dependencies
npm install

# Start the Express server
node simple_server.js
```

Then access the game at:
- http://localhost:8080/ (main page)
- http://localhost:8080/game (game page)

### Option 3: Using the Basic Node.js Server (no dependencies)

```bash
# No installation needed
node basic_server.js
```

Then access the game at:
- http://localhost:8080/ (main page)
- http://localhost:8080/game (game page)

## Game Features

- **Card-based gameplay**: Play cards from your hand onto the battlefield
- **Turn-based mechanics**: Play cards during your turn, then let the AI make its move
- **3D battlefield**: Interactive 3D environment using Three.js
- **Health system**: Each player has 20 health points
- **Simple AI opponent**: Computer opponent plays cards automatically

## How to Play

1. Click the "Play Game" button on the main menu
2. Click on a card in your hand to play it on the battlefield
3. When you're done, click "End Turn" to let the AI opponent play
4. Continue until one player runs out of health

## Troubleshooting

If you encounter issues with the server version:

1. Try opening the standalone HTML file directly
2. Check if you have the latest version of Node.js
3. Make sure port 8080 is not already in use
4. If running in Gitpod, use the URL provided in the console output

## Technology

- **Frontend**: HTML, CSS, JavaScript
- **Libraries**: React (via CDN), Three.js (via CDN)
- **Server Options**: Express.js or basic Node.js HTTP server

## Features

- **Instant gameplay**: Start playing immediately without registration
- **Turn-based card battles**: Play cards from your hand to the battlefield
- **Bot AI opponent**: Battle against an AI that makes strategic decisions
- **2.5D battlefield**: Immersive game environment rendered with Three.js
- **Card abilities**: Each card has unique abilities, attack, and defense values
- **Dynamic game state**: Real-time updates as gameplay progresses

## Technical Stack

- **Backend**: Ruby on Rails 8.0
- **Database**: PostgreSQL (containerized via Docker)
- **Frontend**: React (in-page JSX with Babel)
- **3D Rendering**: Three.js with OrbitControls
- **Styling**: Custom CSS

## Getting Started

### Prerequisites

- Docker and Docker Compose
- Git

### Installation

1. Clone the repository:
   ```
   git clone <repository-url>
   cd rpggame
   ```

2. Start the application with Docker Compose:
   ```
   docker-compose up
   ```

3. Set up the database (first time only):
   ```
   docker-compose exec web bundle exec rails db:create db:migrate db:seed
   ```

4. Access the application at `http://localhost:3000`

## Game Rules

- Each player starts with 20 health
- Players draw 5 random cards at game start
- On your turn, you can:
  - Play a card from your hand to the battlefield
  - End your turn to let the bot make its move
- Cards battle based on attack and defense stats
- If a card's defense drops to 0 or below, it is destroyed
- When a player's health reaches 0, the game ends

## Development

### Backend API Endpoints

- `GET /api/cards` - Get all available cards
- `GET /api/game/start` - Start a new game with random cards
- `POST /api/game/move` - Submit a player move and get the bot's response

### Project Structure

- `app/controllers/api` - API controllers
- `app/models` - Database models
- `app/views/home` - Main game view
- `app/javascript` - JavaScript assets

## Roadmap

- Multiplayer functionality
- Deck building and card collection
- User accounts and match history
- Enhanced animations and sound effects
- Mobile-responsive design

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Inspired by Riot Games' Legends of Runeterra
- Built with Rails, React, and Three.js

# **Product Requirements Document (PRD): Legends of Runeterra Clone (MVP)**

## **1. Introduction**

The goal of this project is to create a **browser-based Legends of Runeterra clone**, served as a **Rails web app**. The game will be a **single-page application (SPA)** built with **React and Three.js** for rendering a **2.5D battlefield**. The game starts immediately without requiring user login and features a **basic AI bot** as the opponent. Cards will be seeded from a PostgreSQL database with 100 unique characters.

---

## **2. Features Overview**

### **Key Features (MVP)**

- **Game starts instantly on page load**
- **Player vs. AI bot gameplay**
- **Turn-based card battles (Attack/Defense mechanics)**
- **Cards have attack, defense, and unique abilities**
- **Cards are seeded from a PostgreSQL database**
- **Basic bot AI with medium-hard strategy**
- **2.5D game board rendered in Three.js**
- **Animations for attacks and abilities**

### **Nice-to-Have Features (Future Enhancements)**

- Multiplayer mode (real-time PvP)
- Deck customization and card collection system
- Match history and win tracking
- Sound effects and music

---

## **3. Technical Design**

### **3.1 Tech Stack**

- **Frontend:** React, Three.js
- **Backend:** Ruby on Rails
- **Database:** PostgreSQL
- **State Management:** React Context API
- **Deployment:** Render/Heroku for Rails, Vercel for React frontend

### **3.2 Routes and UI Components**

#### **Frontend (React SPA)**

- `/` (Root) → Game board with Three.js-rendered battlefield

#### **Backend (Rails API)**

- `GET /api/cards` → Fetch all cards from the database
- `POST /api/game/start` → Start a new game with randomly assigned cards
- `POST /api/game/move` → Process a player's move and return bot's response

### **3.3 Database Schema**

### **3.4 Game Mechanics**

#### **Basic Rules**

- Each player starts with **X health** (default: 20 HP)
- Players draw **5 random cards** at the start
- Each turn, a player can play a card from their hand onto the battlefield
- The opponent (bot) responds with its own move
- Cards attack each other based on their attack/defense stats
- If an attack exceeds a card's defense, the card is destroyed
- The game ends when a player’s health reaches **0**

#### **Bot AI Strategy**

- Prioritize attacking **weaker** enemy cards first
- If an attack can **kill** a card, execute it
- If the player's board is **stronger**, the bot prioritizes defending
- If the bot has an **open attack opportunity**, it attacks the player's health directly

---

## **4. Implementation Plan**

### **1. Set Up the Rails API Backend**

1. use the exisiting rails 8 app
2. Create the `cards` model and migrate the database
3. Seed the database with 100 random characters using Faker
4. Create controllers for `GET /api/cards` and `POST /api/game/start`
5. Implement game logic and AI decision-making in the backend

### **2. Build the React Frontend**

1. Initialize a new React project: `npx create-react-app lor-frontend`
2. Install dependencies: `npm install three axios @react-three/fiber`
3. Create the main `GameBoard` component with Three.js rendering
4. Fetch cards from the Rails backend and store them in state
5. Implement UI components: `Card`, `Hand`, `Battlefield`

### **3. Implement Game Logic and AI**

1. Track player and bot health in React state
2. Implement turn-based mechanics and attack resolution
3. Send moves to the Rails API and process bot responses
4. Animate card movements and attacks with Three.js

---

---

This PRD outlines the **minimum viable product (MVP)** with a **turn-based card game against a bot, implemented with React, Three.js, and Rails**. Let me know if you'd like any adjustments before development starts! 🚀


**Product Requirements Document (PRD): Vue.js Migration for Warlocks Reach (Standalone RPG Card Game)**

---

### **0. Current Implementation Overview**

- **Game Name:** Warlocks Reach  
- **Tech Stack:**
  - HTML/CSS/JavaScript (no bundlers)
  - React + Babel inline in `standalone.html`
  - Three.js used for 3D game board and effects
- **UI/UX:** All logic and components embedded in one HTML file.
- **Core Mechanics:** Turn-based RPG card game with draw/play/battle/end turn phases.
- **Limitations:**
  - Three.js rendering may break in unsupported environments
  - Monolithic structure (hard to maintain/debug)
  - Not scalable for multiplayer or modular enhancements

---

### **1. Migration Objective**

Rebuild the game using **Vue 3** and remove all **Three.js and React dependencies**.
Everything must be contained in a single file (`standalone_vue.html`).

**Goals:**
- Remove 3D rendering (Three.js)
- Replace React components with Vue 3 Composition API components
- Keep all gameplay logic, UI layout, and functionality intact
- Retain all animations and CSS as is or replace with Vue-friendly equivalents
- Future-proof for multiplayer expansion

---

### **2. Features Overview**

#### ✅ Key Features (MVP)
- Full RPG card game flow (draw, play, battle, end turn)
- Combat mechanics (target selection, board state updates, damage/death resolution)
- Player vs. AI logic with basic AI card plays
- Visual components: player hand, bot hand, battlefield, combat log
- UI interactions: hover, click, attack animations

#### 🌟 Nice-to-Have Features
- Multiplayer-ready architecture (socket triggers, hooks)
- Configurable card sets and deck sizes
- Debug toggles or dev mode for testing cards/state
- Optimized rendering of card state changes

---

### **3. Routes & UI Components**

#### `/standalone_vue.html`
- **Purpose:** All game logic and UI in a single Vue-powered HTML file.
- **Components:**
  - `MainMenu`: Shows game intro, card previews, and start button
  - `GameBoard`: Displays battlefield, player/bot zones, hand and stats
  - `Card`: Reusable component for both board and hand views
  - `CombatLog`: Scrollable text log for battle updates
  - `Game`: Root game state manager
  - `App`: Root switch between menu and game

---

### **4. Third-Party Tools**

- **Vue 3 (Composition API)** – via CDN:
```html
<script src="https://unpkg.com/vue@3/dist/vue.global.prod.js"></script>
```

- No build tooling (e.g., Webpack, Babel) – must run as-is in the browser.

---

### **5. State Management Strategy**

Use Vue 3's `reactive()` and `ref()` to store and track game state globally.

```js
const gameState = reactive({
  player: { health: 20, mana: 1, hand: [], board: [], deck: [] },
  bot: { health: 20, mana: 1, hand: [], board: [], deck: [] },
  turn: 'player',
  turnNumber: 1,
  attacker: null,
  defender: null,
  combatLog: [],
  message: ''
});
```

Functions such as `drawCard()`, `playCard()`, `battle()`, and `endTurn()` mutate `gameState`.

---

### **6. Component Architecture**

| Component        | Purpose                                  | Integration                     |
|------------------|------------------------------------------|----------------------------------|
| `MainMenu`       | Shows splash + card preview + start btn  | Uses static list of sample cards|
| `Card`           | Reusable card block (stats, events)      | Props: card, Events: `@click`   |
| `HandZone`       | Displays hand of cards                   | Binds to `gameState.player.hand`|
| `BoardZone`      | Player/bot field                         | Binds to board state            |
| `CombatLog`      | Shows last 10 events                     | Watches `gameState.combatLog`   |
| `Game`           | Contains game loop logic and actions     | Reactive game control           |
| `App`            | Entry point (menu ↔ game switch)         | Toggles view via `ref()`        |

---

### **7. Implementation Plan (MVP Only)**

#### 1. Set Up Basic HTML and Vue 3 App Wrapper
- Add Vue 3 CDN
- Create `<div id="app"></div>` in body
- Inline `<script type="module">` with:
  - `createApp()`
  - Define `App.vue` logic with `ref()` for screen switching

#### 2. Migrate Game State from React to Vue
- Replace `useState()` with `reactive()` for gameState
- Transfer initial structure and helper methods (`drawCard`, `shuffleDeck`, etc.)
- Define all state-altering logic inside `setup()`

#### 3. Rebuild MainMenu in Vue
- Create `<template>` with splash UI
- Port `.main-menu` styles
- Use `v-if="screen === 'menu'"`
- On button click, toggle `screen.value = 'game'`

#### 4. Convert Game UI Components
- Recreate `GameBoard`, `Card`, `HandZone`, `CombatLog` in `<script setup>`
- Replace React props with `defineProps()` and `emit()`
- Replace React event handlers with `@click`, `@mouseover`

#### 5. Remove All Three.js References
- Delete:
  - OrbitControls
  - `initializeBattlefield()`
  - `<div id="canvas-container">`
- Replace any remaining references with fallback CSS styles (already present)

#### 6. Replace ReactDOM.render with Vue Mount
- At end of file, mount app:
```js
createApp(App).mount('#app')
```

---

### **8. Documentation & External References**

- **Vue 3 Docs:** https://vuejs.org/guide/introduction.html
- **Coolify Deployment:** https://docs.coolify.io/
- **Canvas-to-CSS 2D Migration:** All 3D visuals now use `battlefield-2d` and `.card` classes

---

This PRD is structured for immediate implementation of a Vue 3 single-file standalone app. Let me know if you’d like the actual file scaffold created or multiplayer support added next.


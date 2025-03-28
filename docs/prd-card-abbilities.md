**Product Requirements Document (PRD): Enter-the-Battlefield (ETB) Abilities for Cards**

---

### **0. Context and Existing Game Engine Overview**

- **Tech Stack:** Pure frontend using HTML, CSS, and Vue.js (Vue 3 via CDN).
- **Game Engine:** All game logic lives on the frontend.
- **Current Card Structure:**
```js
{ name: "Goblin", attack: 1, defense: 1, manaCost: 1 }
```
- **Gameplay Zones:** Deck, Hand, Board.
- **Flow:** Player & Bot alternate turns. Cards played from hand to board. No existing card abilities.

---

### **1. Feature Overview**

We want to allow cards to have **enter-the-battlefield (ETB) abilities** that trigger as soon as they are played from the hand to the board. These abilities can:

- Affect hand cards (add/remove attack or defense)
- Damage opponent battlefield/board or health
- Apply status effects (e.g., temporary protection)

---

### **2. Features Breakdown**

#### **Key Feature: Dynamic ETB Abilities for Cards**

- Each card can optionally define an `ability` field (already implemented)
- The ability executes **immediately** upon entering the battlefield
- Effects are scoped to the board, hand, or health values

---

### **3. Technical Design**

#### **3.1 Card Data Schema Extension**
Update the card schema to support abilities:
```js
{
  name: "Arcane Bomber",
  attack: 2,
  defense: 1,
  manaCost: 3,
  ability: {
    trigger: "enterBattlefield",
    type: "damageOpponentHand",
    value: 1
  }
}
```

**Supported Ability Types:**
- `damageOpponentHand` → Deal X damage to all opponent hand cards
- `buffOwnHand` → Add X attack and/or defense to all own hand cards
- `protectHand` → Apply temporary protection status (to be tracked with turn counters)

---

#### **3.2 Ability Execution Engine**
Implement a function:
```js
function handleCardAbility(card, owner, gameState)
```
- `card`: The card being played
- `owner`: "player" or "bot"
- `gameState`: The full reactive game state object

**Responsibilities:**
- Check for `card.ability`
- Match against supported ability types
- Apply changes to game state synchronously
- Log actions to combat log

**Example logic for damageOpponentHand:**
```js
if (ability.type === "damageOpponentHand") {
  const opponent = owner === 'player' ? 'bot' : 'player';
  gameState[opponent].hand.forEach(c => c.defense -= ability.value);
}
```

---

#### **3.3 UI Feedback**

- Damage should be visually represented with animations and a floating damage number (reuse `.damage-number` class)
- Buffs and protection should show temporary visual cues (e.g., glow on card)

---

### **4. Vue Component Integration Plan**

#### **Integration Point**
Inside the `playCard()` method in `Game` component:
- After pushing card to `board`, call `handleCardAbility(card, 'player', gameState)`

In `botPlayCard()`, do the same:
- After playing, call `handleCardAbility(card, 'bot', gameState)`

---

### **5. State Management for Timed Effects (e.g., Protection)**

Introduce per-card metadata tracking, e.g.:
```js
{
  ...card,
  status: {
    protected: 2  // Lasts for 2 turns
  }
}
```
- Decrement protection counters each turn
- Ignore effects (e.g. damage) if `card.status.protected > 0`

---


---

### **7. Implementation Plan (MVP Only)**

#### **1. Extend Card Data with Abilities**
- [ ] Add optional `ability` field to existing cardData array

#### **2. Create Ability Engine**
- [ ] Create `handleCardAbility(card, owner, gameState)` method
- [ ] Implement support for:
  - [ ] `damageOpponentHand`
  - [ ] `buffOwnHand`
  - [ ] `protectHand`

#### **3. Integrate Ability Execution**
- [ ] In `playCard()`, call `handleCardAbility()`
- [ ] In `botPlayCard()`, call `handleCardAbility()`

#### **4. Add Visual Feedback**
- [ ] Use `combatLog` to log each ability trigger
- [ ] Trigger existing animations or overlays (use `.damage-number`)

#### **5. Protection Turn Decay**
- [ ] On each `endTurn()`, decrement `card.status.protected`
- [ ] In damage logic, skip damage if `card.status.protected > 0`

---

### **8. Documentation / Developer Notes**

#### **Comment in Code**
Detailed documentation in the code. PLease add as many comments as you tihink make sense in the code to keep the code clear and understanable for other developers

#### **Card Authoring Guide**
- New cards can define ability like this:
```js
{
  name: "Frost Imp",
  attack: 2,
  defense: 1,
  manaCost: 2,
  ability: { trigger: "enterBattlefield", type: "buffOwnHand", value: 1 }
}
```


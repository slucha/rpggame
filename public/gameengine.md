    // === GAME ENGINE RULE COMMENTS ===

    /**
     * --- Game Setup ---
     * - Two players: player & bot
     * - Each player has: health (20), mana (0-10), hand (5 cards), deck, board (max 6 cards)
     * 
     * --- Card Structure ---
     * - name: string
     * - attack: number
     * - defense: number
     * - manaCost: number
     * - ability: string (optional)
     * 
     * --- Card Zones ---
     * 1. ✅ Deck (a.k.a. Library)
     *    - Hidden pile of cards
     *    - Drawn one per turn
     *    - A deck consits of 40 cards 
     * 
     * 2. ✋ Hand
     *    - Visible to the player (not opponent)
     *    - Each opponent starts with 5 cards on his hand
     *    - Cards drawn from the deck
     *    - You can only play cards from your hand
     *    - Max hand size = 10
     *    - Drawing beyond that: card is burned (discarded)
     * 
     * 3. ⚔️ Board (a.k.a. Battlefield)
     *    - Where units (cards) are placed when played
     *    - These are in play and can attack/block
     *    - Max 6 units per player
     * 
     * --- Turn Flow ---
     * 1. Start of turn: gain mana, draw card
     * 2. Main Phase: play cards, spend mana
     * 3. Attack Phase: attacker selects attackers, defender assigns blockers
     * 4. Combat resolves: damage dealt simultaneously
     * 5. End Phase: check for win/loss, swap turn
     * 
     * --- Combat Rules ---
     * - Max 6 units on board
     * - One blocker per attacker
     * - If attack > defense → unit dies
     * - Unblocked attackers deal damage to enemy health
     * 
     * --- Mana Rules ---
     * - +1 mana per turn, max 10
     * - Spells & units cost mana (spells omitted for MVP)
     * 
     * --- Bot Strategy (MVP AI) ---
     * - Play strongest card it can afford
     * - Attack with all units unless badly outnumbered
     * - Prefer 1:1 trades on defense
     * 
     * --- Victory Conditions ---
     * - A player loses when health <= 0
     */

-- Game settings
local playerHealth = 100
local playerAttack = 20
local monsterHealth = 50
local monsterAttack = 15
local turn = 1  -- Track the turns

-- Game state
local gameRunning = true

-- Player stats
local player = {
    health = playerHealth,
    attack = playerAttack
}

-- Monster stats
local monster = {
    health = monsterHealth,
    attack = monsterAttack
}

-- Display the current game state
local function printStatus()
    term.clear()
    term.setCursorPos(1, 1)
    print("====== DOOM GAME ======")
    print("Player Health: " .. player.health)
    print("Monster Health: " .. monster.health)
    print("Turn: " .. turn)
end

-- Player attacks monster
local function playerAttackMonster()
    monster.health = monster.health - player.attack
    print("You attack the monster for " .. player.attack .. " damage!")
end

-- Monster attacks player
local function monsterAttackPlayer()
    player.health = player.health - monster.attack
    print("The monster attacks you for " .. monster.attack .. " damage!")
end

-- Game over check
local function checkGameOver()
    if player.health <= 0 then
        print("You have been defeated by the monster!")
        gameRunning = false
    elseif monster.health <= 0 then
        print("You defeated the monster!")
        gameRunning = false
    end
end

-- Main game loop
local function mainLoop()
    while gameRunning do
        printStatus()

        -- Player turn
        print("Choose your action: ")
        print("1. Attack the monster")
        print("2. Run away (Escape battle)")

        local choice = read()

        if choice == "1" then
            playerAttackMonster()
            monsterAttackPlayer()
        elseif choice == "2" then
            print("You ran away from the battle.")
            gameRunning = false
        else
            print("Invalid choice. Try again.")
        end

        checkGameOver()

        if gameRunning then
            turn = turn + 1
            print("Press any key to continue to the next turn...")
            read()
        end
    end
end

-- Start the game
mainLoop()

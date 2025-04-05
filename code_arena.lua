-- Settings
local arenaWidth = 10
local arenaHeight = 10
local sleepTime = 0.3

-- Create bot object
local function createBot(name, x, y, ai)
    return {
        name = name,
        x = x,
        y = y,
        hp = 10,
        ai = ai
    }
end

-- Check if bots are adjacent
local function isAdjacent(bot1, bot2)
    local dx = math.abs(bot1.x - bot2.x)
    local dy = math.abs(bot1.y - bot2.y)
    return dx + dy == 1
end

-- Draw arena
local function render(bots)
    term.clear()
    term.setCursorPos(1, 1)
    for y = 1, arenaHeight do
        for x = 1, arenaWidth do
            local cell = "."
            for i, bot in ipairs(bots) do
                if bot.hp > 0 and bot.x == x and bot.y == y then
                    cell = tostring(i)
                end
            end
            io.write(cell .. " ")
        end
        print()
    end
    print()
    for i, bot in ipairs(bots) do
        print("[" .. i .. "] " .. bot.name .. " - HP: " .. bot.hp)
    end
end

-- Aggressive bot logic
local function aggressiveAI(myX, myY, enemyX, enemyY)
    local dx = (enemyX > myX) and 1 or (enemyX < myX and -1 or 0)
    local dy = (enemyY > myY) and 1 or (enemyY < myY and -1 or 0)
    return { move = { dx, dy }, attack = true }
end

-- Defensive bot logic
local function cautiousAI(myX, myY, enemyX, enemyY)
    local dist = math.abs(myX - enemyX) + math.abs(myY - enemyY)
    if dist <= 1 then
        local dx = (enemyX < myX) and 1 or (enemyX > myX and -1 or 0)
        local dy = (enemyY < myY) and 1 or (enemyY > myY and -1 or 0)
        return { move = { dx, dy }, attack = true }
    end
    return { move = { 0, 0 }, attack = false }
end

-- Create bots
local bot1 = createBot("Aggressor", 2, 2, aggressiveAI)
local bot2 = createBot("Runner", 9, 9, cautiousAI)
local bots = { bot1, bot2 }

-- Game loop
local round = 1
while bot1.hp > 0 and bot2.hp > 0 do
    print("=== Round " .. round .. " ===")
    for i, bot in ipairs(bots) do
        if bot.hp > 0 then
            local enemy = bots[(i % 2) + 1]
            local action = bot.ai(bot.x, bot.y, enemy.x, enemy.y)
            local dx = action.move[1]
            local dy = action.move[2]
            bot.x = math.max(1, math.min(arenaWidth, bot.x + dx))
            bot.y = math.max(1, math.min(arenaHeight, bot.y + dy))

            if action.attack and isAdjacent(bot, enemy) then
                enemy.hp = enemy.hp - 2
                print(bot.name .. " attacks " .. enemy.name .. "!")
            end
        end
    end
    render(bots)
    sleep(sleepTime)
    round = round + 1
end

-- End of game
term.setCursorPos(1, arenaHeight + 5)
local winner = (bot1.hp > 0) and bot1 or bot2
print("🏆 Winner: " .. winner.name)
print("Press any key to exit...")
os.pullEvent("key")

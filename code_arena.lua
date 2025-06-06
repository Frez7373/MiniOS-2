-- Settings
local arenaWidth = 10
local arenaHeight = 10
local sleepTime = 0.4

-- Color setup
local function setColor(bg, txt)
    term.setBackgroundColor(bg)
    term.setTextColor(txt)
end

-- Draw arena
local function render(bots)
    term.clear()
    term.setCursorPos(1, 1)
    for y = 1, arenaHeight do
        for x = 1, arenaWidth do
            local drawn = false
            for i, bot in ipairs(bots) do
                if bot.hp > 0 and bot.x == x and bot.y == y then
                    setColor(bot.color, colors.white)
                    term.write(tostring(i))
                    setColor(colors.black, colors.white)
                    drawn = true
                    break
                end
            end
            if not drawn then
                setColor(colors.gray, colors.lightGray)
                term.write(".")
            end
        end
        print()
    end

    -- Info HUD
    print()
    for i, bot in ipairs(bots) do
        setColor(bot.color, colors.white)
        term.write("[" .. i .. "] " .. bot.name)
        setColor(colors.black, colors.white)
        print(" - HP: " .. bot.hp)
    end
end

-- Bot logic
local function createBot(name, x, y, ai, color)
    return {
        name = name,
        x = x,
        y = y,
        hp = 10,
        ai = ai,
        color = color
    }
end

local function aggressiveAI(mx, my, ex, ey)
    local dx = (ex > mx) and 1 or (ex < mx and -1 or 0)
    local dy = (ey > my) and 1 or (ey < my and -1 or 0)
    return { move = { dx, dy }, attack = true }
end

local function cautiousAI(mx, my, ex, ey)
    local dist = math.abs(mx - ex) + math.abs(my - ey)
    if dist <= 1 then
        local dx = (ex < mx) and 1 or (ex > mx and -1 or 0)
        local dy = (ey < my) and 1 or (ey > my and -1 or 0)
        return { move = { dx, dy }, attack = true }
    end
    return { move = { 0, 0 }, attack = false }
end

-- Start Game
local function startGame()
    local bot1 = createBot("Aggressor", 2, 2, aggressiveAI, colors.red)
    local bot2 = createBot("Runner", 9, 9, cautiousAI, colors.blue)
    local bots = { bot1, bot2 }

    local round = 1
    while bot1.hp > 0 and bot2.hp > 0 do
        render(bots)
        term.setCursorPos(1, arenaHeight + 5)
        print("Round " .. round)

        for i, bot in ipairs(bots) do
            if bot.hp > 0 then
                local enemy = bots[(i % 2) + 1]
                local action = bot.ai(bot.x, bot.y, enemy.x, enemy.y)
                local dx = action.move[1]
                local dy = action.move[2]
                bot.x = math.max(1, math.min(arenaWidth, bot.x + dx))
                bot.y = math.max(1, math.min(arenaHeight, bot.y + dy))

                if action.attack and math.abs(bot.x - enemy.x) + math.abs(bot.y - enemy.y) == 1 then
                    enemy.hp = enemy.hp - 2
                    term.setCursorPos(1, arenaHeight + 6)
                    print(bot.name .. " attacks " .. enemy.name .. "!")
                end
            end
        end

        sleep(sleepTime)
        round = round + 1
    end

    -- Game end
    local winner = (bot1.hp > 0) and bot1 or bot2
    render(bots)
    term.setCursorPos(1, arenaHeight + 8)
    setColor(colors.green, colors.white)
    print("🏆 Winner: " .. winner.name)
    setColor(colors.black, colors.white)
    print("Press Enter to exit...")
    read()  -- Wait for user to press Enter to exit
end

-- Directly start the game without any menu
startGame()

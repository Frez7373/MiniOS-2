-- Простая шахматная доска для терминала CC: Tweaked

-- Инициализация доски
local board = {
    {"r","n","b","q","k","b","n","r"},
    {"p","p","p","p","p","p","p","p"},
    {" "," "," "," "," "," "," "," "},
    {" "," "," "," "," "," "," "," "},
    {" "," "," "," "," "," "," "," "},
    {" "," "," "," "," "," "," "," "},
    {"P","P","P","P","P","P","P","P"},
    {"R","N","B","Q","K","B","N","R"}
}

-- Печать доски
local function drawBoard()
    term.clear()
    term.setCursorPos(1,1)
    print("  a b c d e f g h")
    for y = 1, 8 do
        local line = tostring(9 - y) .. " "
        for x = 1, 8 do
            local piece = board[y][x]
            if piece == " " then piece = "." end
            line = line .. piece .. " "
        end
        print(line .. tostring(9 - y))
    end
    print("  a b c d e f g h")
end

-- Перевод ввода (например, "e2") в координаты таблицы
local function parseCoord(input)
    if type(input) ~= "string" or #input ~= 2 then return nil end
    local file = string.sub(input,1,1):lower()
    local rank = tonumber(string.sub(input,2,2))
    if not rank or rank < 1 or rank > 8 then return nil end
    local x = string.byte(file) - 96
    local y = 9 - rank
    if x < 1 or x > 8 then return nil end
    return {x = x, y = y}
end

-- Основной цикл
while true do
    drawBoard()

    write("From (e.g. e2): ")
    local fromInput = read()
    local from = parseCoord(fromInput)
    if not from then print("Invalid input.") sleep(1) goto skip end

    write("To (e.g. e4): ")
    local toInput = read()
    local to = parseCoord(toInput)
    if not to then print("Invalid input.") sleep(1) goto skip end

    -- Перемещаем фигуру
    local piece = board[from.y][from.x]
    if piece == " " then
        print("No piece at that square!") sleep(1) goto skip
    end
    board[to.y][to.x] = piece
    board[from.y][from.x] = " "

    ::skip::
end

-- Очистка экрана
term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.clear()

-- Символы фигур (можно заменить на обычные буквы, если шрифт не поддерживает)
local pieces = {
    r = "r", n = "n", b = "b", q = "q", k = "k", p = "p",
    R = "R", N = "N", B = "B", Q = "Q", K = "K", P = "P"
}

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

-- Функция отрисовки доски
local function drawBoard()
    term.setCursorPos(1, 1)
    print("  a b c d e f g h")
    for y = 1, 8 do
        local row = tostring(9 - y) .. " "
        for x = 1, 8 do
            local piece = board[y][x]
            row = row .. (pieces[piece] or ".") .. " "
        end
        print(row .. tostring(9 - y))
    end
    print("  a b c d e f g h")
end

-- Функция преобразования ввода в координаты
local function parseCoord(input)
    if #input ~= 2 then return nil end
    local file = input:sub(1, 1):lower()
    local rank = tonumber(input:sub(2, 2))
    local x = string.byte(file) - 96
    local y = 9 - rank
    if x >= 1 and x <= 8 and y >= 1 and y <= 8 then
        return {x = x, y = y}
    end
    return nil
end

-- Главный цикл игры
while true do
    drawBoard()
    
    -- Считываем откуда
    write("\nFrom (e.g., e2): ")
    local fromCoord = read()
    local from = parseCoord(fromCoord)
    
    if not from then
        print("Invalid FROM coordinate!")
        sleep(1)
    else
        local piece = board[from.y][from.x]
        if piece == " " then
            print("No piece at that square!")
            sleep(1)
        else
            -- Считываем куда
            write("To (e.g., e4): ")
            local toCoord = read()
            local to = parseCoord(toCoord)

            if not to then
                print("Invalid TO coordinate!")
                sleep(1)
            else
                -- Делаем ход
                board[to.y][to.x] = piece
                board[from.y][from.x] = " "
            end
        end
    end
end

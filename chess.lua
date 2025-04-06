term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.clear()

local pieces = {
    r = "♜", n = "♞", b = "♝", q = "♛", k = "♚", p = "♟",
    R = "♖", N = "♘", B = "♗", Q = "♕", K = "♔", P = "♙"
}

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

local function drawBoard()
    term.setCursorPos(1,1)
    print("  a  b  c  d  e  f  g  h")
    for y = 1, 8 do
        io.write(9 - y .. " ")
        for x = 1, 8 do
            local bg = (x + y) % 2 == 0 and colors.lightGray or colors.gray
            term.setBackgroundColor(bg)
            local piece = board[y][x]
            term.setTextColor(colors.black)
            if pieces[piece] then
                io.write(" " .. pieces[piece] .. "")
            else
                io.write("   ")
            end
            term.setBackgroundColor(colors.black)
        end
        print(" " .. (9 - y))
    end
    print("  a  b  c  d  e  f  g  h")
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
end

local function parseCoord(coord)
    if #coord ~= 2 then return nil end
    local file = string.byte(coord:sub(1,1):lower()) - 96
    local rank = 9 - tonumber(coord:sub(2,2))
    if file >= 1 and file <= 8 and rank >= 1 and rank <= 8 then
        return {x = file, y = rank}
    end
    return nil
end

while true do
    drawBoard()
    write("\nEnter piece to move (e.g., e2): ")
    local from = parseCoord(read())
    if not from then print("Invalid input.") sleep(1) goto continue end

    write("Enter destination (e.g., e4): ")
    local to = parseCoord(read())
    if not to then print("Invalid input.") sleep(1) goto continue end

    local piece = board[from.y][from.x]
    if piece == " " then
        print("No piece there!") sleep(1) goto continue
    end

    board[to.y][to.x] = piece
    board[from.y][from.x] = " "

    ::continue::
end

local apps = {
  {name = "Calculator", file = "apps/calculator.lua", color = colors.orange},
  {name = "Game", file = "apps/game.lua", color = colors.green},
  {name = "Clock", file = "apps/clock.lua", color = colors.purple},
  {name = "Notes", file = "apps/notes.lua", color = colors.cyan},
  {name = "Calendar", file = "apps/calendar.lua", color = colors.blue}  -- Добавлена кнопка календаря
}

local function drawButton(label, x, y, w, h, bg, fg)
  paintutils.drawFilledBox(x, y, x+w-1, y+h-1, bg)
  term.setCursorPos(x + math.floor((w - #label) / 2), y + math.floor(h / 2))
  term.setTextColor(fg or colors.white)
  write(label)
end

local function drawMenu()
  term.setBackgroundColor(colors.gray)
  term.clear()
  local w, h = term.getSize()
  term.setCursorPos(math.floor(w/2 - 4), 1)
  term.setTextColor(colors.yellow)
  print("== MiniOS 1.5 ==")

  -- Отображаем кнопки приложений
  for i, app in ipairs(apps) do
    drawButton(app.name, 6, 2 + i * 3, w - 12, 3, app.color)
  end
  -- Кнопка выхода
  drawButton("Exit", 6, 3 + (#apps + 1) * 3, w - 12, 3, colors.red)
end

local function getButton(x, y)
  for i, app in ipairs(apps) do
    local bx, by, bw, bh = 6, 2 + i * 3, term.getSize() - 12, 3
    if x >= bx and x <= bx + bw - 1 and y >= by and y <= by + bh - 1 then return i end
  end
  local bx, by = 6, 3 + (#apps + 1) * 3
  if y >= by and y <= by + 2 then return 0 end
end

while true do
  drawMenu()
  local _, _, x, y = os.pullEvent("mouse_click")
  local sel = getButton(x, y)
  if sel == 0 then break end
  if sel then shell.run(apps[sel].file) end
end

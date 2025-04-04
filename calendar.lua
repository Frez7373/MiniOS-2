-- apps/calendar.lua
local daysOfWeek = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"}

-- Get the current date
local function getCurrentDate()
  local date = os.date("*t")
  return date.year, date.month, date.day
end

-- Get the number of days in a specific month and year
local function getDaysInMonth(year, month)
  local daysInMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
  -- Check for leap year for February
  if month == 2 then
    if (year % 4 == 0 and year % 100 ~= 0) or (year % 400 == 0) then
      return 29
    else
      return 28
    end
  else
    return daysInMonth[month]
  end
end

-- Get the weekday of the first day of the month
local function getFirstDayOfMonth(year, month)
  local firstDay = os.date("*t", os.time{year = year, month = month, day = 1}).wday
  return firstDay
end

-- Function to draw the calendar
local function drawCalendar(year, month)
  local daysInMonth = getDaysInMonth(year, month)
  local firstDay = getFirstDayOfMonth(year, month)

  -- Define the initial offset (for aligning the weekdays)
  local calendar = {}
  local currentDay = 1
  for i = 1, 6 do
    local row = {}
    for j = 1, 7 do
      if (i == 1 and j >= firstDay) or (i > 1 and currentDay <= daysInMonth) then
        row[j] = currentDay
        currentDay = currentDay + 1
      else
        row[j] = ""
      end
    end
    table.insert(calendar, row)
  end

  -- Print the header
  term.setBackgroundColor(colors.white)
  term.setTextColor(colors.black)
  term.clear()
  term.setCursorPos(1, 1)
  print("Calendar: " .. os.date("%B %Y", os.time{year = year, month = month}))

  -- Print the weekdays
  term.setTextColor(colors.white)
  for i = 1, 7 do
    term.setCursorPos(i * 6 - 5, 2)
    write(daysOfWeek[i])
  end

  -- Print the calendar days
  for i, row in ipairs(calendar) do
    for j, day in ipairs(row) do
      term.setCursorPos(j * 6 - 5, i + 2)
      if day ~= "" then
        write(string.format("%2d", day))
      else
        write("   ")
      end
    end
  end
end

-- Main loop
local year, month, day = getCurrentDate()

-- Display the calendar for the current month
drawCalendar(year, month)

-- Wait for key press to return to the main menu
print("\nPress any key to return to the main menu.")
os.pullEvent("key")

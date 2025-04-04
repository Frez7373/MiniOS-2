local function getTextInput()
  -- Clear the screen and set background color
  term.setBackgroundColor(colors.black)
  term.setTextColor(colors.white)
  term.clear()
  
  -- Prepare for text output
  term.setCursorPos(1, 1)
  write("Enter text to print: ")

  -- Get text input from the user
  local input = read()

  -- Check if the printer is connected
  local printer = peripheral.wrap("right")  -- Make sure the printer is connected to the right
  if not printer then
    print("Printer not connected!")
    return
  end

  -- Clear the printer before printing
  printer.clear()
  
  -- Print the text to the printer
  printer.write(input)
  
  -- Notification that printing is complete
  print("Text printed!")
end

-- Call the function to input and print text
getTextInput()

-- Check if the disk is available
local disk = peripheral.find("disk")
if not disk then
    print("Disk not found!")
    return
end

-- Mount the disk
disk.mount()

-- Try to run the Pastebin file
local success, errorMessage = pcall(function()
    -- Download and execute the file from Pastebin
    pastebin.run("xLC8mABU")
end)

-- Check if the download was successful
if success then
    print("File successfully downloaded and executed!")
else
    print("Error downloading file: " .. errorMessage)
end

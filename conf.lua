function love.conf(t)
    t.identity = "zombie-sacrifice"     -- The name of the save directory (string)
    t.version = "11.0"                  -- The LÖVE version this game was made for (string)
    t.console = false                   -- Attach a console (boolean, Windows only)
 
    t.window.title = "Zombie Sacrifice" -- The window title (string)
    t.window.icon = "img/Logo.png"      -- Filepath to an image to use as the window's icon (string)
    t.window.width = 1280               -- The window width (number)
    t.window.height = 720               -- The window height (number)
    t.window.resizable = false          -- Let the window be user-resizable (boolean)
    t.window.display = 1                -- Index of the monitor to show the window in (number)
end
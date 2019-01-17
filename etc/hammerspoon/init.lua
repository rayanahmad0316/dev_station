require 'utils'

hs.window.animationDuration = 0

hs.grid.setGrid({ w = 20, h = 20 })
hs.grid.setMargins({ w = 0, h = 0 })

hs.hotkey.bind({ "alt", "cmd" }, "Left", function()
    hs.grid.pushWindowLeft()
end)
hs.hotkey.bind({ "alt", "cmd" }, "Right", function()
    hs.grid.pushWindowRight()
end)
hs.hotkey.bind({ "alt", "cmd" }, "Down", function()
    hs.grid.pushWindowDown()
end)
hs.hotkey.bind({ "alt", "cmd" }, "Up", function()
    hs.grid.pushWindowUp()
end)

hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "Right", function()
    local window = hs.window.focusedWindow()
    window:moveOneScreenEast()
    hs.grid.snap(window)
end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "Left", function()
    local window = hs.window.focusedWindow()
    window:moveOneScreenWest()
    hs.grid.snap(window)
end)

hs.hotkey.bind({ "cmd" }, "Left", function()
    hs.grid.resizeWindowThinner()
end)
hs.hotkey.bind({ "cmd" }, "Right", function()
    hs.grid.resizeWindowWider()
end)
hs.hotkey.bind({ "cmd" }, "Down", function()
    hs.grid.resizeWindowTaller()
end)
hs.hotkey.bind({ "cmd" }, "Up", function()
    hs.grid.resizeWindowShorter()
end)
hs.hotkey.bind({ "alt" }, "Left", function()
    local window = hs.window.focusedWindow()
    maskWindowOperation(window, function(window)
        hs.grid.pushWindowLeft(window)
        hs.grid.resizeWindowWider(window)
    end)
end)
hs.hotkey.bind({ "alt" }, "Right", function()
    local window = hs.window.focusedWindow()
    maskWindowOperation(window, function(window)
        hs.grid.resizeWindowThinner(window)
        hs.grid.pushWindowRight(window)
    end)
end)
hs.hotkey.bind({ "alt" }, "Down", function()
    local window = hs.window.focusedWindow()
    maskWindowOperation(window, function(window)
        hs.grid.resizeWindowShorter(window)
        hs.grid.pushWindowDown(window)
    end)
end)
hs.hotkey.bind({ "alt" }, "Up", function()
    local window = hs.window.focusedWindow()
    maskWindowOperation(window, function(window)
        hs.grid.pushWindowUp(window)
        hs.grid.resizeWindowTaller(window)
    end)
end)

bindKeysAdjustWindow({ "cmd" }, { "5", "pad5" }, 0, 0, 20, 20)
bindKeysAdjustWindow({ "cmd" }, { "1", "pad1" }, 0, 10, 10, 10)
bindKeysAdjustWindow({ "cmd" }, { "4", "pad4" }, 0, 0, 10, 20)
bindKeysAdjustWindow({ "cmd" }, { "7", "pad7" }, 0, 0, 10, 10)
bindKeysAdjustWindow({ "cmd" }, { "8", "pad8" }, 0, 0, 20, 10)
bindKeysAdjustWindow({ "cmd" }, { "9", "pad9" }, 10, 0, 10, 10)
bindKeysAdjustWindow({ "cmd" }, { "6", "pad6" }, 10, 0, 10, 20)
bindKeysAdjustWindow({ "cmd" }, { "3", "pad3" }, 10, 10, 10, 10)
bindKeysAdjustWindow({ "cmd" }, { "2", "pad2" }, 0, 10, 20, 10)

window_layout = hs.window.layout.new({
    -- Comms Screen (-1,0=left)
    -- Maximized
    -- { hs.window.filter.new({ Calendar = { allowRoles = "AXStandardWindow" } }), "move all focused [50,0,50,100] 1,0 | min" },
    -- { hs.window.filter.new(false):setAppFilter("Google Chrome", { visible = true, allowRoles = "AXStandardWindow", allowTitles = "Hangouts" }), "tile 2 focused 1x2 [0,0,100,100] 1,0 | min" },

    -- Left 50%
    { hs.window.filter.new({ Mail = { allowRoles = "AXStandardWindow" } }), "tile 2 focused 2x1 [50,0,100,100] 0,0 | min" },
    { hs.window.filter.new({ Spotify = { allowRoles = "AXStandardWindow" } }), "tile 2 focused 2x1 [0,0,50,100] 0,0 | min" },
    { hs.window.filter.new({ WhatsApp = { allowRoles = "AXStandardWindow" } }), "tile 2 focused 2x1 [0,0,50,100] 0,0 | min" },

    -- Right 50%
    -- { hs.window.filter.new({ iTunes = { allowRoles = "AXStandardWindow", rejectTitles = "MiniPlayer" } }), "fit 1 [50,0,100,100] -1,0 | min" },

    -- Top 60%
    { hs.window.filter.new({ Slack = { allowRoles = "AXStandardWindow" } }), "fit 1 [50,0,100,100] 0,0 | min" },
    -- Bottom 40%
    -- { hs.window.filter.new({ Messages = { allowRoles = "AXStandardWindow" } }), "fit 1 [50,60,100,100] -1,0 | min" },


    -- Tools Screen (0,0=center)
    -- Left 65%
    { hs.window.filter.new(false):setAppFilter("Google Chrome", { visible = true, allowRoles = "AXStandardWindow", rejectTitles = { "DevTools", "Lucidchart", "Hangouts" } }), "tile 2 focused 2x1 [0,0,70,100] -1,-1 | min" },
    { hs.window.filter.new({ SourceTree = { allowRoles = "AXStandardWindow" } }), "tile 2 focused 2x1 [0,0,50,100] 0,0 | min" },
    --{ hs.window.filter.new({ MySQLWorkbench = { allowRoles = "AXStandardWindow" } }), "tile 2 focused 2x1 [0,0,65,100] 0,0 | min" },

    -- Right 35%
    { hs.window.filter.new({ Terminal = { allowRoles = "AXStandardWindow" } }), "tile 4 focused 2x1 [70.0,0.0,100.0,100.0] -1,-1 | min" },
    { hs.window.filter.new({ Firefox = { visible = true, allowRoles = "AXStandardWindow" } }), "tile 2 focused 2x1 [0,0,70,100] -1,-1 | min" },
    { hs.window.filter.new(false):setAppFilter("Google Chrome", { visible = true, allowRoles = "AXStandardWindow", allowTitles = "DevTools" }), "tile 2 focused 2x1 [70,0,100,100] -1,0 | min" },
    { hs.window.filter.new(false):setAppFilter("Google Chrome", { visible = true, allowRoles = "AXStandardWindow", allowTitles = "Developer Tools" }), "tile 2 focused 2x1 [70,0,100,100] -1,0 | min" },
    { hs.window.filter.new({ python = { allowRoles = "AXStandardWindow" } }), "tile 2 focused 2x1 [0,0,70,100] -1,-1 | min" },

    -- Code Screen (1,0=right)
    { hs.window.filter.new({ PyCharm = { allowRoles = "AXStandardWindow", allowTitles = "/Documents/GitHub", rejectTitles = "Replace Usage" } }), "move all focused [0,0,100,100] 0,-1" },
    -- { hs.window.filter.new(false):setAppFilter("Google Chrome", { visible = true, allowRoles = "AXStandardWindow", allowTitles = "Lucidchart" }), "move all focused [0,0,100,100] -1,0" },
})

function fix_bottom_margin(win)
    hs.grid.resizeWindowShorter(win)
    hs.grid.resizeWindowTaller(win)
end

function fix_layout()
    window_layout:apply()

    local status, err = pcall(function()
        hs.layout.apply({
            -- Put the iTunes miniplayer in the bottom right corner
            -- in the unused space not taken by the dock
            { "iTunes", "MiniPlayer", hs.screen.primaryScreen(), nil, nil, hs.geometry.rect(-350, -45, 350, 45) },
        })
    end)
end

fix_layout()

hs.hotkey.bind({ "cmd" }, "L", fix_layout)

hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "P", function()
    window_layout:stop()
end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "S", function()
    window_layout:start()
end)

-- Get around paste blocking
hs.hotkey.bind({ "cmd", "alt" }, "V", function()
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

window_layout:start()

hs.alert.show("Config loaded")

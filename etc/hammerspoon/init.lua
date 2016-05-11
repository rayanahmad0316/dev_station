require 'utils'

hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "R", function()
    hs.reload()
end)

hs.window.animationDuration = 0

hs.grid.setGrid({ w = 10, h = 10 })
hs.grid.setMargins({ w = 1, h = 1 })

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

bindKeysAdjustWindow({ "cmd" }, { "5", "pad5" }, 0, 0, 10, 10)
bindKeysAdjustWindow({ "cmd" }, { "1", "pad1" }, 0, 5, 5, 5)
bindKeysAdjustWindow({ "cmd" }, { "4", "pad4" }, 0, 0, 5, 10)
bindKeysAdjustWindow({ "cmd" }, { "7", "pad7" }, 0, 0, 5, 5)
bindKeysAdjustWindow({ "cmd" }, { "8", "pad8" }, 0, 0, 10, 5)
bindKeysAdjustWindow({ "cmd" }, { "9", "pad9" }, 5, 0, 5, 5)
bindKeysAdjustWindow({ "cmd" }, { "6", "pad6" }, 5, 0, 5, 10)
bindKeysAdjustWindow({ "cmd" }, { "3", "pad3" }, 5, 5, 5, 5)
bindKeysAdjustWindow({ "cmd" }, { "2", "pad2" }, 0, 5, 10, 5)

local screens_plus2 = {left={x=-1,y=0}, center={x=0, y=0}, right={x=1, y=0}}
local screens_plus1 = {center={x=0, y=0}, right={x=1, y=0}}
local screens_plus0 = {center={x=0, y=0}}

window_layout = hs.window.layout.new({
    -- Comms Screen (1,0=right)
        -- Maximized
        {hs.window.filter.new({Calendar={}}), "fit 1 focused [0,0,100,100] 1,0 | min"},

        -- Left 50%
        {hs.window.filter.new({Mail={}}), "tile 2 focused 2x1 [0,0,50,100] 1,0 | min"},

        -- Right 50%
        {hs.window.filter.new({iTunes={allowTitles="iTunes"}}), "fit 1 [50,0,100,100] 1,0 | min"},

            -- Top 70%
            {hs.window.filter.new({Slack={allowTitles="Slack"}}), "fit 1 [50,0,100,70] 1,0 | min"},

            -- Bottom 30%
            {hs.window.filter.new({Messages={}}), "fit 1 [50,70,100,100] 1,0 | min"},


    -- Tools Screen (0,0=center)
        -- Left 40%
        {hs.window.filter.new({Terminal={}}), "tile 2 focused 2x1 [0,0,40,100] 0,0 | min"},

        -- Right 60%
        {hs.window.filter.new("Google Chrome"), "tile 2 focused 2x1 [40,0,100,100] 0,0 | min"},
        {hs.window.filter.new({SourceTree={}}), "tile 2 focused 2x1 [40,0,100,100] 0,0 | min"},
        {hs.window.filter.new({MySQLWorkbench={}}), "tile 2 focused 2x1 [40,0,100,100] 0,0 | min"},

    -- Code Screen (-1,0=left)
        {hs.window.filter.new({PyCharm={}}), "fit 1 focused [0,0,100,100] -1,0 | min"},
})

function apply_window_layout()
    window_layout:apply()

    local primaryScreen = hs.screen.primaryScreen()

    local centerScreen = primaryScreen
    local leftScreen = centerScreen:toWest() or centerScreen
    local rightScreen = centerScreen:toEast() or centerScreen

    local commsScreen = rightScreen
    local toolsScreen = centerScreen
    local codeScreen = leftScreen

    hs.layout.apply({
        -- Put the iTunes miniplayer in the bottom right corner
        -- in the unused space not taken by the dock
        { "iTunes", "MiniPlayer", toolsScreen, nil, nil, hs.geometry.rect(-350, -45, 350, 45) },

    })

    -- These rules can use regular expressions for value of window name (2nd parameter,
    -- enabled by 'string.match' parameter to hs.layout.apply()).
    hs.layout.apply({
        -- Put the Chrome developer tools window beside next to the browser window
        -- instead of on top of it.
        { "Google Chrome", "^Developer Tools.*$", toolsScreen, hs.geometry.rect(0, 0, 0.4, 1), nil, nil },

        -- Lucid Chart editor gets the whole codeScreen
        { "Google Chrome", ": Lucidchart$", codeScreen, hs.geometry.rect(0, 0, 1, 1), nil, nil },
    }, string.match)

    for index, win in pairs(hs.window.visibleWindows()) do
        if win:title() ~= "MiniPlayer" then
            hs.grid.snap(win)
            -- Allow for bottom margin bug
            hs.grid.resizeWindowShorter(win)
            hs.grid.resizeWindowTaller(win)
        end
    end
end

--window_layout:start()
apply_window_layout()

hs.hotkey.bind({ "cmd" }, "L", apply_window_layout)
hs.screen.watcher.new(apply_window_layout):start()

hs.alert.show("Config loaded")

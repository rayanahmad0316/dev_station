require 'utils'

hs.window.animationDuration = 0

hs.grid.setGrid({ w = 8, h = 8 })
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
    maskWindowOperation(window, function()
        hs.grid.pushWindowLeft(window)
        hs.grid.resizeWindowWider(window)
    end)
end)
hs.hotkey.bind({ "alt" }, "Right", function()
    local window = hs.window.focusedWindow()
    maskWindowOperation(window, function()
        hs.grid.resizeWindowThinner(window)
        hs.grid.pushWindowRight(window)
    end)
end)
hs.hotkey.bind({ "alt" }, "Down", function()
    local window = hs.window.focusedWindow()
    maskWindowOperation(window, function()
        hs.grid.resizeWindowShorter(window)
        hs.grid.pushWindowDown(window)
    end)
end)
hs.hotkey.bind({ "alt" }, "Up", function()
    local window = hs.window.focusedWindow()
    maskWindowOperation(window, function()
        hs.grid.pushWindowUp(window)
        hs.grid.resizeWindowTaller(window)
    end)
end)

bindKeysAdjustWindow({ "cmd" }, { "5", "pad5" }, 0, 0, 8, 8)
bindKeysAdjustWindow({ "cmd" }, { "1", "pad1" }, 0, 4, 4, 4)
bindKeysAdjustWindow({ "cmd" }, { "4", "pad4" }, 0, 0, 4, 8)
bindKeysAdjustWindow({ "cmd" }, { "7", "pad7" }, 0, 0, 4, 4)
bindKeysAdjustWindow({ "cmd" }, { "8", "pad8" }, 0, 0, 8, 4)
bindKeysAdjustWindow({ "cmd" }, { "9", "pad9" }, 4, 0, 4, 4)
bindKeysAdjustWindow({ "cmd" }, { "6", "pad6" }, 4, 0, 4, 8)
bindKeysAdjustWindow({ "cmd" }, { "3", "pad3" }, 4, 4, 4, 4)
bindKeysAdjustWindow({ "cmd" }, { "2", "pad2" }, 0, 4, 8, 4)

function layout()
    local laptopScreen = hs.screen.findByName("Color LCD")
    local comsScreen = laptopScreen
    local mainScreen = comsScreen:toEast() or comsScreen
    local secondaryScreen = mainScreen:toEast() or mainScreen

    hs.layout.apply({
        --Communications / Administration Apps
        { "Calendar", nil, comsScreen, hs.geometry.rect(0, 0, 1, 1), nil, nil },
        { "Mail", nil, comsScreen, hs.geometry.rect(0, 0, 0.5, 1), nil, nil },
        { "Messages", nil, comsScreen, hs.geometry.rect(0.5, 0, 0.5, 1), nil, nil },
        { "Slack", nil, comsScreen, hs.geometry.rect(0.5, 0, 0.5, 1), nil, nil },

        -- Misc Developer Tools
        -- Left 3/8
        { "Terminal", nil, mainScreen, hs.geometry.rect(0, 0, 0.375, 1), nil, nil },
        -- Right 5/8
        { "Google Chrome", nil, mainScreen, hs.geometry.rect(0.375, 0, 0.625, 1), nil, nil },
        { "SourceTree", nil, mainScreen, hs.geometry.rect(0.375, 0, 0.625, 1), nil, nil },
        { "MySQLWorkbench", nil, mainScreen, hs.geometry.rect(0.375, 0, 0.625, 1), nil, nil },
        { "iTunes", "iTunes", mainScreen, hs.geometry.rect(0.375, 0, 0.625, 1), nil, nil },

        -- Put the iTunes miniplayer in the bottom right corner
        -- in the unused space not taken by the dock
        { "iTunes", "MiniPlayer", mainScreen, nil, nil, hs.geometry.rect(-350, -45, 350, 45) },

        -- Coding IDE gets a screen all to itself
        { "PyCharm", nil, secondaryScreen, hs.geometry.rect(0, 0, 1, 1), nil, nil },
    })

    hs.layout.apply({
        { "Google Chrome", "Developer Tools.*", mainScreen, hs.geometry.rect(0, 0, 0.375, 1), nil, nil },
    })

    for index, win in pairs(hs.window.visibleWindows()) do
        if win:title() ~= "MiniPlayer" then
            hs.grid.snap(win)
        end
    end
end

hs.hotkey.bind({ "cmd" }, "L", layout)
hs.screen.watcher.new(layout):start()
layout()

hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "R", function()
    hs.reload()
end)
hs.alert.show("Config loaded")

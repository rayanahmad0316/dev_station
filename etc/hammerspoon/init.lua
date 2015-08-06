require 'displaygrid'

grid = DisplayGrid(10, 10)

grid:bindKeys({"cmd"}, {"5", "pad5"}, 1, 1, 10, 10)
grid:bindKeys({"cmd"}, {"1", "pad1"}, 1, 6, 5, 10)
grid:bindKeys({"cmd"}, {"4", "pad4"}, 1, 1, 5, 10)
grid:bindKeys({"cmd"}, {"7", "pad7"}, 1, 1, 5, 5)
grid:bindKeys({"cmd"}, {"8", "pad8"}, 1, 1, 10, 5)
grid:bindKeys({"cmd"}, {"9", "pad9"}, 6, 1, 10, 5)
grid:bindKeys({"cmd"}, {"6", "pad6"}, 6, 1, 10, 10)
grid:bindKeys({"cmd"}, {"3", "pad3"}, 6, 6, 10, 10)
grid:bindKeys({"cmd"}, {"2", "pad2"}, 1, 6, 10, 10)

grid:bindKeys({"ctrl", "alt", "cmd"}, {"1"}, 10, 1, 10, 10)
grid:bindKeys({"ctrl", "alt", "cmd"}, {"2"}, 9, 1, 10, 10)
grid:bindKeys({"ctrl", "alt", "cmd"}, {"3"}, 8, 1, 10, 10)
grid:bindKeys({"ctrl", "alt", "cmd"}, {"4"}, 7, 1, 10, 10)
grid:bindKeys({"ctrl", "alt", "cmd"}, {"5"}, 6, 1, 10, 10)
grid:bindKeys({"ctrl", "alt", "cmd"}, {"6"}, 5, 1, 10, 10)
grid:bindKeys({"ctrl", "alt", "cmd"}, {"7"}, 4, 1, 10, 10)
grid:bindKeys({"ctrl", "alt", "cmd"}, {"8"}, 3, 1, 10, 10)
grid:bindKeys({"ctrl", "alt", "cmd"}, {"9"}, 2, 1, 10, 10)

grid:bindKeys({"shift", "ctrl", "alt"}, {"1"}, 1, 1, 1, 10)
grid:bindKeys({"shift", "ctrl", "alt"}, {"2"}, 1, 1, 2, 10)
grid:bindKeys({"shift", "ctrl", "alt"}, {"3"}, 1, 1, 3, 10)
grid:bindKeys({"shift", "ctrl", "alt"}, {"4"}, 1, 1, 4, 10)
grid:bindKeys({"shift", "ctrl", "alt"}, {"5"}, 1, 1, 5, 10)
grid:bindKeys({"shift", "ctrl", "alt"}, {"6"}, 1, 1, 6, 10)
grid:bindKeys({"shift", "ctrl", "alt"}, {"7"}, 1, 1, 7, 10)
grid:bindKeys({"shift", "ctrl", "alt"}, {"8"}, 1, 1, 8, 10)
grid:bindKeys({"shift", "ctrl", "alt"}, {"9"}, 1, 1, 9, 10)

hs.window.animationDuration = 0

hs.hotkey.bind({"cmd"}, "Right", function()
    hs.window.focusedWindow():moveOneScreenEast()
end)
hs.hotkey.bind({"cmd"}, "Left", function()
    hs.window.focusedWindow():moveOneScreenWest()
end)

function layout()
    local comsScreen = hs.screen.findByName("Color LCD")
    local mainScreen = comsScreen:toEast()
    local secondaryScreen = mainScreen:toEast()

    hs.alert.show("comsScreen: " .. comsScreen:name())
    hs.alert.show("mainScreen: " .. mainScreen:name())
    hs.alert.show("secondaryScreen: " .. secondaryScreen:name())

    hs.layout.apply({
        {"Calendar", nil, comsScreen, nil, grid:rectForGrid(comsScreen, 1, 1, 5, 10), nil},
        {"Mail", nil, comsScreen, nil, grid:rectForGrid(comsScreen, 1, 1, 5, 10), nil},
        {"Messages", nil, comsScreen, nil, grid:rectForGrid(comsScreen, 6, 1, 10, 10), nil},
        {"Slack", nil, comsScreen, nil, grid:rectForGrid(comsScreen, 6, 1, 10, 10), nil},

        {"Terminal", nil, mainScreen, nil, grid:rectForGrid(mainScreen, 1, 1, 4, 10), nil},
        {"SourceTree", nil, mainScreen, nil, grid:rectForGrid(mainScreen, 5, 1, 10, 10), nil},

        {"PyCharm", nil, secondaryScreen, nil, grid:rectForGrid(secondaryScreen, 1, 1, 10, 10), nil},
        {"Google Chrome", nil, secondaryScreen, nil, grid:rectForGrid(secondaryScreen, 1, 1, 10, 10), nil},
    })
end
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "L", layout)
--layout()

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")
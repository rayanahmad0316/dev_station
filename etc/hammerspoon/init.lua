require 'utils'

bindKeysMoveFocusedWindow({"cmd"}, {"5", "pad5"}, 0, 0, 1, 1)
bindKeysMoveFocusedWindow({"cmd"}, {"1", "pad1"}, 0, 0.5, 0.5, 1)
bindKeysMoveFocusedWindow({"cmd"}, {"4", "pad4"}, 0, 0, 0.5, 1)
bindKeysMoveFocusedWindow({"cmd"}, {"7", "pad7"}, 0, 0, 0.5, 0.5)
bindKeysMoveFocusedWindow({"cmd"}, {"8", "pad8"}, 0, 0, 1, 0.5)
bindKeysMoveFocusedWindow({"cmd"}, {"9", "pad9"}, 0.5, 0, 1, 0.5)
bindKeysMoveFocusedWindow({"cmd"}, {"6", "pad6"}, 0.5, 0, 1, 1)
bindKeysMoveFocusedWindow({"cmd"}, {"3", "pad3"}, 0.5, 0.5, 1, 1)
bindKeysMoveFocusedWindow({"cmd"}, {"2", "pad2"}, 0, 0.5, 1, 1)

bindKeysMoveFocusedWindow({"shift", "ctrl", "alt"}, {"1"}, 0, 0, 0.1, 1)
bindKeysMoveFocusedWindow({"shift", "ctrl", "alt"}, {"2"}, 0, 0, 0.2, 1)
bindKeysMoveFocusedWindow({"shift", "ctrl", "alt"}, {"3"}, 0, 0, 0.3, 1)
bindKeysMoveFocusedWindow({"shift", "ctrl", "alt"}, {"4"}, 0, 0, 0.4, 1)
bindKeysMoveFocusedWindow({"shift", "ctrl", "alt"}, {"5"}, 0, 0, 0.5, 1)
bindKeysMoveFocusedWindow({"shift", "ctrl", "alt"}, {"6"}, 0, 0, 0.6, 1)
bindKeysMoveFocusedWindow({"shift", "ctrl", "alt"}, {"7"}, 0, 0, 0.7, 1)
bindKeysMoveFocusedWindow({"shift", "ctrl", "alt"}, {"8"}, 0, 0, 0.8, 1)
bindKeysMoveFocusedWindow({"shift", "ctrl", "alt"}, {"9"}, 0, 0, 0.9, 1)

bindKeysMoveFocusedWindow({"ctrl", "alt", "cmd"}, {"1"}, 0.9, 0, 0.1, 1)
bindKeysMoveFocusedWindow({"ctrl", "alt", "cmd"}, {"2"}, 0.8, 0, 0.2, 1)
bindKeysMoveFocusedWindow({"ctrl", "alt", "cmd"}, {"3"}, 0.7, 0, 0.3, 1)
bindKeysMoveFocusedWindow({"ctrl", "alt", "cmd"}, {"4"}, 0.6, 0, 0.4, 1)
bindKeysMoveFocusedWindow({"ctrl", "alt", "cmd"}, {"5"}, 0.5, 0, 0.5, 1)
bindKeysMoveFocusedWindow({"ctrl", "alt", "cmd"}, {"6"}, 0.4, 0, 0.6, 1)
bindKeysMoveFocusedWindow({"ctrl", "alt", "cmd"}, {"7"}, 0.3, 0, 0.7, 1)
bindKeysMoveFocusedWindow({"ctrl", "alt", "cmd"}, {"8"}, 0.2, 0, 0.8, 1)
bindKeysMoveFocusedWindow({"ctrl", "alt", "cmd"}, {"9"}, 0.1, 0, 0.9, 1)

hs.window.animationDuration = 0

hs.hotkey.bind({"cmd"}, "Right", function()
    hs.window.focusedWindow():moveOneScreenEast()
end)
hs.hotkey.bind({"cmd"}, "Left", function()
    hs.window.focusedWindow():moveOneScreenWest()
end)

function layout()
    local laptopScreen = hs.screen.findByName("Color LCD")
    local comsScreen = laptopScreen
    local mainScreen = comsScreen:toEast() or comsScreen
    local secondaryScreen = mainScreen:toEast() or mainScreen

    hs.layout.apply({
        {"Calendar", nil, comsScreen, hs.geometry.rect(0, 0, 0.5, 1), nil, nil},
        {"Mail", nil, comsScreen, hs.geometry.rect(0, 0, 0.5, 1), nil, nil},
        {"Messages", nil, comsScreen, hs.geometry.rect(0.5, 0, 0.5, 1), nil, nil},
        {"Slack", nil, comsScreen, hs.geometry.rect(0.5, 0, 0.5, 1), nil, nil},

        {"Terminal", nil, mainScreen, hs.geometry.rect(0, 0, 0.4, 1), nil, nil},
        {"SourceTree", nil, mainScreen, hs.geometry.rect(0.4, 0, 0.6, 1), nil, nil},
        {"MySQLWorkbench", nil, mainScreen, hs.geometry.rect(0.4, 0, 0.6, 1), nil, nil},

        {"PyCharm", nil, secondaryScreen, hs.geometry.rect(0, 0, 1, 1), nil, nil},
        {"Google Chrome", nil, secondaryScreen, hs.geometry.rect(0, 0, 1, 1), nil, nil},
    })
end
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "L", layout)
hs.screen.watcher.new(layout):start()
layout()

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")
function bindKeys(mods, keys, pressedfn, releasedfn, repeatfn)
    for index, key in pairs(keys) do
        hs.hotkey.bind(mods, key, pressedfn, releasedfn, repeatfn)
    end
end

function maskWindowOperation(window, windowOpfunc, ...)
    local snap = hs.drawing.image(window:frame(), window:snapshot())
    snap:bringToFront()
    snap:show()
    local returnValue = windowOpfunc(window, ...)
    snap:hide()
    return returnValue
end

function bindKeysMoveToUnit(mods, keys, x, y, w, h)
    bindKeys(mods, keys, function()
        local window = hs.window.focusedWindow()
        maskWindowOperation(window, function()
            window:moveToUnit(hs.geometry.rect(x, y, w, h))
            hs.grid.snap(window)
        end)
    end)
end

function bindKeysAdjustWindow(mods, keys, x, y, w, h)
    bindKeys(mods, keys, function()
        local window = hs.window.focusedWindow()
        maskWindowOperation(window, function()
            hs.grid.adjustWindow(function(cell)
                cell.x = x
                cell.y = y
                cell.w = w
                cell.h = h
            end, window)
        end)
    end)
end

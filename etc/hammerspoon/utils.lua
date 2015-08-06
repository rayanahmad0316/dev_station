function bindKeys(mods, keys, pressedfn, releasedfn, repeatfn)
    for index, key in pairs(keys) do
        hs.hotkey.bind(mods, key, pressedfn, releasedfn, repeatfn)
    end
end

function bindKeysMoveFocusedWindow(mods, keys, x, y, w, h)
    bindKeys(mods, keys, function()
        hs.window.focusedWindow():moveToUnit(hs.geometry.rect(x, y, w, h))
    end)
end

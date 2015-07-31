function bindKeys(mods, keys, pressedfn, releasedfn, repeatfn)
    for index, key in pairs(keys) do
        hs.hotkey.bind(mods, key, pressedfn, releasedfn, repeatfn)
    end
end
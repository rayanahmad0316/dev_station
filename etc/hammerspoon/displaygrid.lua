--The creation of this module was folly on my part.
--I didn't understand window:moveToUnit().
--It accomplishes basically the same thing I was
--trying to acheive here, although the form of
--its solution is slightly different.

--I keep this simply as an example implementation
--of a class in Lua, using the class.lua module.

require 'class'
require 'utils'

DisplayGrid = class()
function DisplayGrid:__init(rows, cols)
    self.rows = rows
    self.cols = cols
end
function DisplayGrid:rectForGrid(screen, startRow, startCol, endRow, endCol)
    local screenFrame = screen:frame()

    local cellWidth = math.floor(screenFrame.w / self.rows)
    local cellHeight = math.floor(screenFrame.h / self.cols)

    local windowCellCountWidth = (endRow + 1) - startRow
    local windowCellCountHeight = (endCol + 1) - startCol

    local rect = hs.geometry.rect(
        (startRow - 1) * cellWidth,
        (startCol - 1) * cellHeight,
        windowCellCountWidth * cellWidth,
        windowCellCountHeight * cellHeight
    )
    return rect
end
function DisplayGrid:positionWindow(window, screen, startRow, startCol, endRow, endCol)
    if screen == nil then
        screen = window:screen()
    end

    window:setFrame(self:rectForGrid(screen, startRow, startCol, endRow, endCol))
    window:moveToScreen(screen)
end
function DisplayGrid:positionCurrentWindow(startRow, startCol, endRow, endCol)
    self:positionWindow(hs.window.focusedWindow(), nil, startRow, startCol, endRow, endCol)
end
function DisplayGrid:positionAppWindow(appName, role, screen, startRow, startCol, endRow, endCol)
end
function DisplayGrid:bindKeys(mods, keys, startRow, startCol, endRow, endCol)
    bindKeys(mods, keys, function()
        self:positionCurrentWindow(startRow, startCol, endRow, endCol)
    end)
end

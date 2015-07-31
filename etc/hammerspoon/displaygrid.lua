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
function DisplayGrid:positionCurrentWindow(startRow, startCol, endRow, endCol)
    local window = hs.window.focusedWindow()
    local screen = window:screen()

    window:setFrame(self:rectForGrid(screen, startRow, startCol, endRow, endCol))
    window:moveToScreen(screen)
end
function DisplayGrid:bindKeys(mods, keys, startRow, startCol, endRow, endCol)
    bindKeys(mods, keys, function()
        self:positionCurrentWindow(startRow, startCol, endRow, endCol)
    end)
end

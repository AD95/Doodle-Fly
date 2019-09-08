-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require "composer"

_G.highestScore=0

-- load menu screen
composer.gotoScene( "splash" )

physics.setDrawMode("normal")	

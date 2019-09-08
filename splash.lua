-----------------------------------------------------------------------------------------
--
-- splash.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImageRect( "background1.png", display.contentWidth, display.contentHeight )
	background.x, background.y = display.contentCenterX, display.contentCenterY
	
	local titleLogo = display.newText("Doodle Fly",0,0,native.systemFont,50)
	titleLogo.x = display.contentWidth * 0.5
	titleLogo.y = 90
	
	
	ship = display.newImageRect( "Icon-hdpi.png", 100, 100 )
	ship.x, ship.y = display.contentCenterX, display.contentCenterY
	
	Btn = display.newText("Created by Adarsh Telkur and Ankitha Prem",0,0,native.systemFont,14)
	Btn.x = display.contentWidth*0.5
	Btn.y = display.contentHeight - 80
	
	sceneGroup:insert( background )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( ship )
	sceneGroup:insert( Btn )
end

local scenee=function()
	composer.gotoScene("menu",fade,500);
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		timer1=timer.performWithDelay(3500,scenee,1);
	
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
		display.remove(sceneGroup)
	end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
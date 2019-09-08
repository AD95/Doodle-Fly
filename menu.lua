-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local newScore=_G.highestScore
local oldScore=0
local path = system.pathForFile( "score.txt", system.DocumentsDirectory )

local fh, reason = io.open( path, "r" )

if fh then
   
    oldScore = fh:read("*number")
    print( "Old contents of "..path.."\n"..oldScore )
	
	if oldScore < newScore then
		io.close(fh)
		local fh1,reason=io.open(path,"w+")
		fh1:write( newScore )
		io.close(fh1)
		print( "New contents of " .. path .. "\n" .. newScore )
	else
		_G.highestScore=oldScore
		newScore=oldScore
	end
else
    print( "Reason open failed: " .. reason ) 

    local fh2,reason = io.open( path, "w+" )

    if fh2 then
        print( "Created file" )
    else
        print( "Create file failed!" )
    end
	oldScore=newScore
	fh2:write( newScore )
	print("Write successful")
	io.close(fh2)
	end
file=nil 
--------------------------------------------

local playBtn
local helpText

local function help()
	helpBtn.alpha=0
	helpText.alpha=1
end

local function onPlayBtnRelease()
	scene:destroy()
	composer.gotoScene( "level1", "fade", 0 )
	return true
end

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImageRect( "background1.png", display.contentWidth, display.contentHeight )
	background.x, background.y = display.contentCenterX, display.contentCenterY
	
	local titleLogo = display.newText("Doodle Fly",0,0,native.systemFont,50)
	titleLogo.x = display.contentWidth * 0.5
	titleLogo.y = 90
	
	highScore = display.newText("Highest Score : "..newScore,0,0,native.systemFontItalic,12)
	highScore.x = display.contentWidth*0.5
	highScore.y = 150
	
	ship = display.newImageRect( "Icon-hdpi.png", 100, 100 )
	ship.x, ship.y = display.contentCenterX, display.contentCenterY
	
	playBtn = display.newText("Click to start!",0,0,native.systemFont,12)
	playBtn.x = display.contentWidth*0.5
	playBtn.y = display.contentHeight - 125
	
	Btn = display.newText("Created by Adarsh Telkur and Ankitha Prem",0,0,native.systemFont,14)
	Btn.x = display.contentWidth*0.5
	Btn.y = display.contentHeight - 80
	
	Mask = display.newImageRect( "mask.png", display.contentWidth, display.contentHeight)
	Mask.x,Mask.y= display.contentCenterX, display.contentCenterY - 50
	
	helpBtn = display.newText("Help?",0,0,native.systemFont,12)
	helpBtn.x = display.contentWidth*0.5
	helpBtn.y = display.contentHeight - 35
	
	helpText = display.newText("Avoid asteroids by touching the screen\nto move the ship in the opposite direction.",0,0,native.systemFont,12)
	helpText.x = display.contentCenterX
	helpText.y = display.contentHeight - 25
	helpText.alpha=0
	
	sceneGroup:insert( background )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( highScore)
	sceneGroup:insert( ship )
	sceneGroup:insert( playBtn )
	sceneGroup:insert( Btn )
	sceneGroup:insert( Mask )
	sceneGroup:insert( helpBtn )
	sceneGroup:insert( helpText )
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
		
		composer.removeScene("level1",false) --if its true then it stores the level1 scene 
		Mask:addEventListener("touch",onPlayBtnRelease) --touch event 
		helpBtn:addEventListener("touch",help)
	
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
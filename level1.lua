-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5
local backgroundTiles = {}
local ship,mask,comet,mask1,mask3
local ships,shipsxy=1,0 --number,direction
local shipsx, shipsy = 25,screenH-100
local x=1
local score,level=0,1
local speed=5
local cometx,comety=0,0

function scene:create( event )

	sceneGroup = self.view
	
	backgroundTiles[0] = display.newImageRect( "background1.png", display.contentWidth, display.contentHeight)
	backgroundTiles[0].x = display.contentCenterX
	backgroundTiles[0].y = display.contentCenterY
	sceneGroup:insert(backgroundTiles[0])
	backgroundTiles[1] = display.newImageRect( "background2.png", display.contentWidth, display.contentHeight)
	backgroundTiles[1].x = display.contentCenterX
	backgroundTiles[1].y = display.contentCenterY - backgroundTiles[1].contentHeight
	sceneGroup:insert(backgroundTiles[1])
	
	
	ship = display.newImageRect( "ship1.gif", 0, 0 )
	ship.x,ship.y=shipsx,shipsy
	sceneGroup:insert( ship )
	physics.addBody( ship,"dynamic",{isSensor=true})
	ship.name="ship"
	
	comet = display.newImageRect("comet1.gif",0,0)
	comet.x,comet.y=0,0
	sceneGroup:insert(comet)
	physics.addBody(comet,"dynamic",{isSensor=true})
	comet.name="comet1"
	
	score2=display.newText("Score: " .. score,0,0,native.systemFont,12)
	score2.x,score2.y=screenW-40,20
	sceneGroup:insert(score2)
	
	mask4=display.newText("Level : "..level,0,0,native.systemFont,12);
	mask4.x,mask4.y=40,20;
	sceneGroup:insert(mask4)
	
	mask3=display.newText("Pause?",0,0,native.systemFont,12);
	mask3.x,mask3.y=halfW,20;
	sceneGroup:insert(mask3)
	
	mask=display.newImageRect("mask.png",display.contentWidth,display.contentHeight)
	mask.x,mask.y=display.contentCenterX,display.contentCenterY+50
	sceneGroup:insert(mask)
	
	mask1=display.newImageRect("mask.png",display.contentWidth,50)
	mask1.x,mask1.y=display.contentCenterX,25
	sceneGroup:insert(mask1)

end


local function listener( event )

	if shipsx==25 then
		shipsxy=0
	elseif shipsx==screenW-25 then
		shipsxy=1
	end
	
	if ships==11 then
		ships=1
	end
	
	if ships==0 then
		ships=10
	end
	
	if ships~=10 and ships~=0 then
		local shipsxyz=ships/10
		local integralPart, fractionalPart = math.modf(shipsxyz)
		ships=fractionalPart*10
	end
	
	if shipsxy==0 then
		shipsx=shipsx+speed
	elseif shipsxy==1 then
		shipsx=shipsx-speed
	end
	
	if shipsx<25 then
		shipsx=25
	elseif shipsx>screenW-25 then
		shipsx=screenW-25
	end
	
	if shipsx==25 then
		shipsxy=0
	elseif shipsx==screenW-25 then
		shipsxy=1
	end
	
	ships=ships+x

    	if ships==1 then
		ship:removeSelf()
		ship=display.newImageRect("ship2.gif",70,50)

	elseif ships==2 then
		ship:removeSelf()
		ship=display.newImageRect("ship3.gif",70,50)

	elseif ships==3 then
		ship:removeSelf()
		ship=display.newImageRect("ship4.gif",70,50)

	elseif ships==4 then
		ship:removeSelf()
		ship=display.newImageRect("ship5.gif",70,50)
	
	elseif ships==5 then
		ship:removeSelf()
		ship=display.newImageRect("ship6.gif",70,50)
	
	elseif ships==6 then
		ship:removeSelf()
		ship=display.newImageRect("ship7.gif",70,50)
	
	elseif ships==7 then
		ship:removeSelf()
		ship=display.newImageRect("ship8.gif",70,50)
	
	elseif ships==8 then
		ship:removeSelf()
		ship=display.newImageRect("ship9.gif",70,50)
	
	elseif ships==9 then
		ship:removeSelf()
		ship=display.newImageRect("ship10.gif",70,50)
	
	elseif ships==10 then
		ship:removeSelf()
		ship=display.newImageRect("ship1.gif",70,50)
	end
	
	ship.x,ship.y=shipsx,shipsy
	physics.addBody(ship,"dynamic",{isSensor=true})
	ship.name="ship"
	
end

local ncomets,comets,cometspeed=0,1,5
local comett=100

local function listener2(event)

	comet:removeSelf()
	ncomets=ncomets-0.01
	comety=comety+cometspeed

	if comets==1 then
		comets=2
		comet=display.newImageRect("comet2.gif",30,70)

	elseif comets==2 then
		comets=3
		comet=display.newImageRect("comet3.gif",30,70)

	elseif comets==3 then
		comets=4
		comet=display.newImageRect("comet4.gif",30,70)

	elseif comets==4 then
		comets=1
		comet=display.newImageRect("comet1.gif",30,70)
	end

	comet.x,comet.y=cometx,comety
	physics.start()
	physics.addBody(comet,"dynamic",{isSensor=true})
	comet.name="comet"
end


local function listener1(event)

	if ncomets<1 then
		timer3=timer.performWithDelay(25,listener2,100)
		ncomets=ncomets+1
		cometx=math.random(25,screenW-25)
		comety,comets=0,1
	end
end


local moveBackground = function()
	for i=0, 1, 1 do
		backgroundTiles[i].y = backgroundTiles[i].y + 10
		if backgroundTiles[i].y - backgroundTiles[i].contentHeight/2 >= display.contentHeight then
			backgroundTiles[i].y = 0 - backgroundTiles[i].contentHeight/2
		end
	end
end


-- gameLoop()
local gameLoop = function()
	score2:removeSelf()
	score2=display.newText("Score: " .. score,0,0,native.systemFont,12)
	score2.x,score2.y=screenW-40,20
	sceneGroup:insert(score2)
	mask4:removeSelf()
	mask4=display.newText("Level : "..level,0,0,native.systemFont,12);
	mask4.x,mask4.y=40,20;
	sceneGroup:insert(mask4)
	moveBackground()
end

local dir=0;
local direction=function(event)

	if ( event.phase == "began" ) then
		if dir==0 then
			speed=speed+5
			dir=1
		end
	
		if shipsxy==0 then
			x=-1
			shipsxy=1
	
		elseif shipsxy==1 then
			x=1
			shipsxy=0
		end

	elseif ( event.phase == "ended" ) then
		if dir==1 then
			speed=speed-5
			dir=0
		end

		if shipsxy==0 then
			x=-1
			shipsxy=1

		elseif shipsxy==1 then
			x=1
			shipsxy=0
		end
	end
end


local function over(event)
	composer.removeScene("menu", false)
	composer.gotoScene("menu","fade",500)
end


local function onGlobalCollision(event)

	if(event.object1.name=="comet" and event.object2.name=="ship")or(event.object1.name=="ship" and event.object2.name=="comet") then
		timer.cancel(timer1)
		timer.cancel(timer2)
		timer.cancel(timer3)
		timer.cancel(timer4)
		mask3:removeSelf()
		mask:removeEventListener("touch",direction)
		Runtime:removeEventListener("collision",onGlobalCollision)
		Runtime:removeEventListener( "enterFrame", gameLoop )
		score2:removeEventListener("touch",pause)
		score2:removeSelf()
		score3=display.newText("Score",0,0,native.systemFont,30)
		score3.x,score3.y=screenW/2,screenH/2-40
		score4=display.newText(score,0,0,native.systemFont,30)
		score4.x,score4.y=screenW/2,screenH/2

		if score>_G.highestScore then
			_G.highestScore=score
		end

		Runtime:addEventListener("touch",over)
	end
end


local function score1(event)
	score=score+1
	
	if(score%20==0) then
		level=level+1
		speed=speed+2
	end
end


timer1=timer.performWithDelay(200,score1,0)
timer2=timer.performWithDelay(comett,listener1,0)
timer4=timer.performWithDelay( 17, listener ,0)

Runtime:addEventListener( "enterFrame", gameLoop )
Runtime:addEventListener("collision",onGlobalCollision)

local paused=0;
function resume()

	if paused==1 then
		mask3:removeSelf()
		mask3=display.newText("Pause?",0,0,native.systemFont,12);
		mask3.x,mask3.y=halfW,20;
		timer.resume(timer1)
		timer.resume(timer2)
		timer.resume(timer3)
		timer.resume(timer4)
		Runtime:addEventListener( "enterFrame", gameLoop )
		mask:addEventListener("touch",direction)
		Runtime:addEventListener("collision",onGlobalCollision)
		paused=0
	end
end


function pause()

	if paused==0 then
		Runtime:removeEventListener( "enterFrame", gameLoop )
		mask:removeEventListener("touch",direction)
		Runtime:removeEventListener("collision",onGlobalCollision)
		timer.pause(timer1)
		timer.pause(timer2)
		timer.pause(timer3)
		timer.pause(timer4)
		mask3:removeSelf()
		mask3=display.newText("Resume?",0,0,native.systemFont,12);
		mask3.x,mask3.y=halfW,20;
		paused=1
	else
		resume()
	end
end

		
function scene:show( event )
	--drawBackground()
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		
		physics.start()
		mask:addEventListener("touch",direction)
		mask1:addEventListener("tap",pause)
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
		--physics.stop()
		
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
	Runtime:removeEventListener("touch",over)
	package.loaded[physics] = nil
	display.remove(sceneGroup)
	score3:removeSelf()
	score4:removeSelf()
	physics.stop()
end


local function onSystemEvent( event )
   if ( event.type == "applicationSuspend" ) then
      pause()
   end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
scene:addEventListener( "system", onSystemEvent )

-----------------------------------------------------------------------------------------

return scene
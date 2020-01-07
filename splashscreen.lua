--------------------------------------------------------------------------------------
--
--splash_Sreen.lua
--Created by Nic Riscalas
--Date Nov, 04, 2019
--Description:This is the splash sceen of my CPT

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splashscreen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL SOUNDS
-----------------------------------------------------------------------------------------
local doorsound = audio.loadSound("Sounds/door sounds.mp3")
local doorsoundChannel
local bakerkidssound1 = audio.loadSound("Sounds/baker kids voice 1.mp3")
local bakerkidssound1channel
----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local bkg
local frenchdoor1
local frenchdoor2
local scrollXSpeed = 2
local scrollYSpeed = -3
local scale=0.0000001

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------
local function changescale(event)
    scale=scale+0.01
end
local function opendoors(event)
    frenchdoor1.width=frenchdoor1.width-scale
    frenchdoor2.width=frenchdoor2.width-scale
end

-- The function that will go to the main menu 
local function gotoMainMenu()
   composer.gotoScene( "mainmenu" )
end
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be black
    bkg = display.newImageRect("Images/goldenrays.jpg", 2048/2, 1536/2)
    --anchor the background
    bkg.anchorX=0
    bkg.anchorY=0
    sceneGroup:insert(bkg)

    -- Insert the frenchdoor1 image
    frenchdoor1 = display.newImageRect("Images/CompanyLogoNicR.png", 2048/2, 1536/2)
    -- anchor Y
    frenchdoor1.anchorY=0
    frenchdoor1.anchorX=0
    --set the width to be half of the contentWidth
    frenchdoor1.width=display.contentWidth/2
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( frenchdoor1 )

    -- Insert the frenchdoor2 image
    frenchdoor2 = display.newImageRect("Images/CompanyLogoNicR2.png", 0,1536/2)
    -- anchor the Y to be 0
    frenchdoor2.anchorY=0
    frenchdoor2.anchorX=1
    --set the initial x and y
    frenchdoor2.x=2045/2
    --set the width to be half of the contentWidth
    frenchdoor2.width=display.contentWidth/2
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( frenchdoor2 )

end -- function scene:create( event )
--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        doorsoundchannel = audio.play(doorsound )
        bakerkidssound1channel = audio.play(bakerkidssound1 )
        bakerkidssound2channel = audio.play(bakerkidssound2 )
        bakerkidssound3channel = audio.play(bakerkidssound3 )  
        
        -- Adding Event Listeners
        Runtime:addEventListener("enterFrame", opendoors)
        Runtime:addEventListener("enterFrame", changescale)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 6000, gotoMainMenu)   
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        -- Adding Event Listeners
        Runtime:removeEventListener("enterFrame", opendoors)
        Runtime:removeEventListener("enterFrame", changescale)
     
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-----------------------------------------------------------------------------------------

return scene
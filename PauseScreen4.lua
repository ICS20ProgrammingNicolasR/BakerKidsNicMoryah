-----------------------------------------------------------------------------------------
--
-- PauseScreen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "PauseScreen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
local HomeButton
local ResumeButton
local restartButton
local muteVollumeButton
local volumeButton
local bkg
local cover
-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------
local function Backtolevel2(  )
	composer.hideOverlay("crossFade", 400)
	resumeGamelevel2()
end

local function restartLevel2(  )
    composer.removeScene("level4_screen")
    composer.gotoScene("level4_screen")
end

local function pauseMusic(touch)
    if(touch.phase == "ended")then
        -- Pause the pauseMusic
        audio.pause(level2SoundChannel)  
        muteVolumeButton.isVisible = true
        volumeButton.isVisible = false
        soundOn = false  
    end
end

local function playMusic( touch )
    if(touch.phase == "ended") then
        -- Play playMusic
        audio.resume(level2SoundChannel)
        muteVolumeButton.isVisible = false
        volumeButton.isVisible = true
        soundOn = true
    end
end

local function mainmenuTransition()
    audio.stop(level2SoundChannel)
    composer.removeScene("level2_screen")
    composer.gotoScene( "mainmenu" )
end

local function InstructionsTransition( )
    pauseinstructions = true
    composer.showOverlay( "instructions4", { isModal = true, effect = "fade", time = 100})
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Insert the background image
    bkg = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    --setting to a semi black colour
    bkg:setFillColor(0,0,0,0.5) 
    cover = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.8, display.contentHeight*0.95, 50 )
    --setting its colour
    cover:setFillColor(96/255, 96/255, 96/255)
    -- insert all objects for this scene into the scene group
    sceneGroup:insert(bkg)
    sceneGroup:insert(cover)
    -----------------------------------------------------------------------------------------
	-- MUTE/UNMUTE BUTTONS
	-----------------------------------------------------------------------------------------   
    volumeButton =  display.newImage("Images/volume button2.png", 780, 500)
    volumeButton.width = 200
    volumeButton.height = 200
    volumeButton.isVisible = true

    muteVolumeButton = display.newImage("Images/volume button.png", 780, 500)
    muteVolumeButton.width = 200
    muteVolumeButton.height = 200
    muteVolumeButton.isVisible = false
    sceneGroup:insert( muteVolumeButton )
    sceneGroup:insert( volumeButton )
    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    resumeButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*4/8,
            

            -- Insert the images here
            defaultFile = "Images/playbuttonlevel2.png",
            overFile = "Images/playbuttonlevel2.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Backtolevel2         
        } )
    restartButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*4/5,
            y = display.contentHeight*3/8,
            

            -- Insert the images here
            defaultFile = "Images/redo.png",
            overFile = "Images/redo.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = restartLevel2          
        } )
    mainmenu = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/4,
            y = display.contentHeight*3/8,
            

            -- Insert the images here
            defaultFile = "Images/home.png",
            overFile = "Images/home.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = mainmenuTransition          
        } )
    instructionsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*3/12,
            y = display.contentHeight*7/10,

            -- Insert the images here
            defaultFile = "Images/InstructionsButton.png",
            overFile = "Images/InstructionsButton.png",
            -- When the button is released, call the Instructions transition function
            onRelease = InstructionsTransition
        } )
    instructionsButton:scale(1,0.5)
    sceneGroup:insert(resumeButton)
    sceneGroup:insert(restartButton)
    sceneGroup:insert(mainmenu)
    sceneGroup:insert(instructionsButton)

end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        native.setKeyboardFocus( nil )
        volumeButton:addEventListener("touch", pauseMusic ) 
        muteVolumeButton:addEventListener("touch", playMusic )
        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then


        if (soundOn == true) then     
            audio.resume(level2SoundChannel)
            muteVolumeButton.isVisible = false
            volumeButton.isVisible = true
        else
            audio.pause(level2SoundChannel)      
            muteVolumeButton.isVisible = true
            volumeButton.isVisible = false
        end
    end
end

--function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        volumeButton:removeEventListener("touch", pauseMusic ) 
        muteVolumeButton:removeEventListener("touch", playMusic )

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
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

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
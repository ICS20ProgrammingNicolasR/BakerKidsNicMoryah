
-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "mainmenu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------
soundOn = true
-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg
local playButton
local creditsButton
local instructionsButton
local volumeButton
local muteVolumeButton

----------------------------------------------------------------------------------------
--LOCAL SOUNDS
----------------------------------------------------------------------------------------
mainMenuSound = audio.loadSound("Sounds/bkgmusic.mp3")
mainMenuSoundChannel = audio.play(mainMenuSound,{loops = -1})
-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

 local function playMusic( touch )
    if(touch.phase == "ended") then
        -- Play playMusic
        audio.resume(mainMenuSoundChannel)
        muteVolumeButton.isVisible = false
        volumeButton.isVisible = true
        soundOn = true
    end
end


 local function pauseMusic(touch)
    if(touch.phase == "ended")then
        -- Pause the pauseMusic
        audio.pause(mainMenuSoundChannel)  
        muteVolumeButton.isVisible = true
        volumeButton.isVisible = false
        soundOn = false  
    end
end

-- Creating Transition Function to Credits Page
local function CreditsTransition( )   
    composer.gotoScene( "credits_screen", {effect = "zoomOutInRotate", time = 1000})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level2screenTransition( )
    mainMenuSound = audio.stop()
    composer.gotoScene( "level2_screen", {effect = "slideLeft", time = 1000})
end    
-------------------------------------------------------------------------------------------
--creating transition to instructions screen 
local function InstructionsTransition( )
    composer.gotoScene( "instructions", {effect = "zoomOutInRotate", time = 1000})
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------


    -- Insert the background image and set it to the center of the screen
    bkg = display.newImageRect("Images/MainMenuMoryah.png", 1536/2, 2048/2)
    bkg.x = display.contentCenterX
    bkg.y = display.contentCenterY
    bkg.width = display.contentWidth
    bkg.height = display.contentHeight
    -- Associating display objects with this scene 
    sceneGroup:insert( bkg )

    -----------------------------------------------------------------------------------------
    -- MUTE/UNMUTE BUTTONS
    -----------------------------------------------------------------------------------------   
    volumeButton =  display.newImage("Images/volume button2.png", 510, 100)
    volumeButton.width = 200
    volumeButton.height = 200
    volumeButton.isVisible = true

    muteVolumeButton = display.newImage("Images/volume button.png", 510, 100)
    muteVolumeButton.width = 200
    muteVolumeButton.height = 200
    muteVolumeButton.isVisible = false

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*7/8,
            

            -- Insert the images here
            defaultFile = "Images/PlayButtonUnPressedNicR.png",
            overFile = "Images/PlayButtonPressedNicR.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level2screenTransition          
        } )
    playButton:scale(1.2,1.2)

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*5/6,
            y = display.contentHeight*9/10,

            -- Insert the images here
            defaultFile = "Images/CreditsButtonUnpressedMoryah.png",
            overFile = "Images/CreditsButtonPressedMoryah.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 
  ----------------------------------------------------------------------------------------------  
    instructionsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*2/12,
            y = display.contentHeight*9/10,

            -- Insert the images here
            defaultFile = "Images/InstructionsButtonUnpressedMoryah.png",
            overFile = "Images/InstructionsButtonPressedMoryah.png",
            -- When the button is released, call the Instructions transition function
            onRelease = InstructionsTransition
        } )



    -- Associating button widgets with this scene
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )
    sceneGroup:insert( muteVolumeButton )
    sceneGroup:insert( volumeButton )    
end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

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
        volumeButton:addEventListener("touch", pauseMusic ) 
        muteVolumeButton:addEventListener("touch", playMusic )

        if (soundOn == true) then     
            audio.resume(mainMenuSoundChannel)
            muteVolumeButton.isVisible = false
            volumeButton.isVisible = true
        else
            audio.pause(mainMenuSoundChannel)      
            muteVolumeButton.isVisible = true
            volumeButton.isVisible = false
        end
    end
end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.

        volumeButton:removeEventListener("touch", pauseMusic ) 
        muteVolumeButton:removeEventListener("touch", playMusic )
    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

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
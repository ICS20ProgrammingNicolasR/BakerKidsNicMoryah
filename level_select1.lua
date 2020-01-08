-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Created by: Moryah
-- Date: nov. 21, 2019
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Naming Scene
sceneName = "level_select"

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local backButton
local level1Button
local level2Button

local muteButton
local unmuteButton
-----------------------------------------------------------------------------------------
local bkgMusic = audio.loadSound("Sounds/bkgmusic.mp3")
local bkgMusicChannel

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------
--SOUNDON = true
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

local function Mute(touch)
    if (touch.phase == "ended") then
        -- pause the Sound
        audio.pause(bkgMusicChannel)
        -- set the boolean variable to be false (sound is now muted)
        SOUNDON = true
        -- hide the mute button
        muteButton.isVisible = false
        -- make the unmute button visible
        unmuteButton.isVisible = true
    end
end

local function Unmute(touch)
    if (touch.phase == "ended") then
        -- pause the Sound
        audio.pause(bkgMusicChannel)
        -- set the boolean variable to be false (sound is now muted)
        SOUNDON = false
        -- hide the mute button
        muteButton.isVisible = true
        -- make the unmute button visible
        unmuteButton.isVisible = false
    end
end

local function BackTransition( )
    composer.gotoScene( "main_menu", {effect = "crossFade", time = 500})
end

-- Creating Transition Function to Credits Page
local function Level1ScreenTransition( )       
    composer.gotoScene( "level1_screen", {effect = "crossFade", time = 500})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level2ScreenTransition( )
    composer.gotoScene( "level2_screen", {effect = "crossFade", time = 500})
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
    bkg_image = display.newImage("Images/LevelSelect.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight
    sceneGroup:insert( bkg_image )

     -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = 140,
        y = display.contentHeight*9/10,

        -- Setting Dimensions
        width = 150,
        height = 70,

        -- Setting Visual Properties
        defaultFile = "Images/BackButtonUnpressedMoryah.png",
        overFile = "Images/BackButtonPressedMoryah.png",

        -- Setting Functional Properties
        onRelease = BackTransition
     } )

    -- Associating display objects with this scene 
    sceneGroup:insert( backButton )


    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating level1 Button
    level1Button = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = 341.33,
            y = 256,

            -- Setting Dimensions
            width = 150,
            height = 70,

            -- Insert the images here
            defaultFile = "Images/1Unpressed.png", 170, 120,
            overFile = "Images/1Pressed.png", 170, 120,

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating level1 Button
    level2Button = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = 682.66,
            y = 256,

            -- Setting Dimensions
            width = 150,
            height = 70,

            -- Insert the images here
            defaultFile = "Images/2Unpressed.png", 170, 120,
            overFile = "Images/2Pressed.png", 170, 120,

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level2ScreenTransition          
        } )
    unmuteButton = display.newImageRect("Images/unmuteButton.png", 90, 90)
    unmuteButton.x = 900
    unmuteButton.y = 148
    unmuteButton.isVisible = false
    -----------------------------------------------------------------------------------------
    muteButton = display.newImageRect("Images/muteButton.png", 90, 90)
    muteButton.x = 900
    muteButton.y = 148
    muteButton.isVisible = true

    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( level1Button )
    sceneGroup:insert( level2Button )
    sceneGroup:insert( unmuteButton )
    sceneGroup:insert( muteButton )

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

        -- The function that will go to the main menu 

    -----------------------------------------------------------------------------------------

    -- Called when the scene is now on screen.
    elseif ( phase == "did" ) then

        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        bkgMusicChannel = audio.play(bkgMusic, {loops= -1})   
        muteButton:addEventListener("touch", Mute)
        unmuteButton:addEventListener("touch", Unmute)
        if ( SOUNDON == true ) then
            audio.resume(bkgMusicChannel)
            unmuteButton.isVisible = true
            muteButton.isVisible = false

        else
            audio.pause(bkgMusicChannel)
            unmuteButton.isVisible = false
            muteButton.isVisible = true

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
        audio.stop(bkgMusicChannel)

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        muteButton:removeEventListener("touch", Mute)
    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
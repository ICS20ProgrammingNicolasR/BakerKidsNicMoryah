-----------------------------------------------------------------------------------------
-- YouWin.lua
-- Created by: Nic Riscalas
-- Date: 12,5,19
-- Description: This shows the player that they won the game and plays a booing sound.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Calling Composer Library
local composer = require( "composer" )

local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "YouWin"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- local variables for the scene
local bkg
local level2button
local mainmenu
local nextlevel
-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------
local function Level1ScreenTransition( )
    composer.removeScene("level1_screen")
    composer.gotoScene( "level1_screen", {effect = "slideLeft", time = 1000})
end 
local function mainmenuTransition()
    composer.removeScene("level1_screen")
   composer.gotoScene( "mainmenu" )
end
local function Level2ScreenTransition( )
    composer.removeScene("level1_screen")
    composer.gotoScene( "level2_screen", {effect = "slideLeft", time = 1000})
end
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------


-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Display background
    bkg = display.newImage("Images/you_win.png")
    bkg.x = display.contentCenterX
    bkg.y = display.contentCenterY
    bkg.width = display.contentWidth
    bkg.height = display.contentHeight
    -----------------------------------------------------------------------------------------     

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg )
    ----------------------------------------------------------------------------------------
--BUTTONS AND WIDGETS
---------------------------------------------------------------------------------------
    level2button = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*7/8,
            

            -- Insert the images here
            defaultFile = "Images/redoWon.png",
            overFile = "Images/redoLost.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )
    mainmenu = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/4,
            y = display.contentHeight*7/8,
            

            -- Insert the images here
            defaultFile = "Images/homeWon.png",
            overFile = "Images/homeLost.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = mainmenuTransition          
        } )
    nextlevel = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*6/8,
            y = display.contentHeight*7/8,
            

            -- Insert the images here
            defaultFile = "Images/next levelWon.png",
            overFile = "Images/next levelLost.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level2ScreenTransition          
        } )
    sceneGroup:insert( level2button )
    sceneGroup:insert( mainmenu ) 
    sceneGroup:insert( nextlevel )
end

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end

end

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
    end

end

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end

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


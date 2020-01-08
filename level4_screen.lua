-----------------------------------------------------------------------------------------
--
-- level2_screen.lua
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
sceneName = "level4_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )
-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------
pauseinstructions = false
saycorrect = false

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg
local ChocolateChips1
local ChocolateChips1TextField
local ChocolateChips2
local ChocolateChips2TextField
local BakingSoda1
local BakingSoda1TextField
local BakingSoda2
local BakingSoda2TextField
local Butter
local ButterTextField
local Eggs1
local Eggs1TextField
local Eggs2
local Flour 
local FlourTextField
local Vanilla
local VanillaTextField
local Salt
local SaltTextField
local Sugar
local SugarTextField
local Bowl
local ChocolateChipsImage
local BakingSodaImage
local ButterImage
local EggsImage 
local FlourImage
local VanillaImage 
local SaltImage 
local SugarImage

local ChocolateChipstimer
local BakingSodaTimer
local ButterTimer
local EggsTimer
local VanillaTimer
local SaltTimer
local SugarTimer

local ANSWERChocolateChips1 = "g"
local ANSWERChocolateChips2 = "r"
local ANSWERBAKINGSODA1 = "g"
local ANSWERBAKINGSODA2 = "a"
local ANSWERBUTTER = "r"
local ANSWEREGGS = "g"
local ANSWERFLOUR = "r"
local ANSWERVanilla = "k"
local ANSWERSALT = "t"
local ANSWERSUGAR = "r"

local CAPITALANSWERChocolateChips1 = "G"
local CAPITOLANSWERChocolateChips2 = "R"
local CAPITOLANSWERBAKINGSODA1 = "G" 
local CAPITOLANSWERBAKINGSODA2 = "A"
local CAPITOLANSWERBUTTER = "R"
local CAPITOLANSWEREGGS = "G"
local CAPITOLANSWERFLOUR = "R"
local CAPITOLANSWERVanilla = "K"
local CAPITOLANSWERSALT = "T"
local CAPITOLANSWERSUGAR = "R"

local userAnswerChocolateChips1
local userAnswerChocolateChips2
local userAnswerBakingSoda1
local userAnswerBakingSoda2
local userAnswerButter
local userAnswerEggs
local userAnswerFlour
local userAnswerVanilla
local userAnswerSalt
local userAnswerSugar

local pauseButton

local totalseconds = 60
local lives = 4
local secondsleft = 60

local BakingPowerComplete = false
local BakingSodaComplete = false
local ButterComplete = false
local EggsComplete = false
local FlourComplete = false
local VanillaComplete = false
local SaltComplete = false
local SugarComplete = false

local totalIngredients = 0

-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
level2Sound = audio.loadSound("Sounds/Level2screenmusic.mp3")
level2SoundChannel = audio.play(level2Sound,{loops = -1})
local correctSound = audio.loadSound("Sounds/correctsound.wav")
local correctSoundChannel
local incorrectSound = audio.loadSound("Sounds/incorrectsound.wav")
local incorrectSoundChannel
-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------
local function HideNumTextfields()
    ChocolateChips1TextField.isVisible = false
    ChocolateChips2TextField.isVisible = false 
    BakingSoda1TextField.isVisible = false
    BakingSoda2TextField.isVisible = false
    ButterTextField.isVisible = false
    Eggs1TextField.isVisible = false
    FlourTextField.isVisible = false
    VanillaTextField.isVisible = false
    SaltTextField.isVisible = false
    SugarTextField.isVisible = false

end

local function ShowNumTextfields()

    if (BakingPowerComplete == true) then
        ChocolateChips1TextField.isVisible = false
        ChocolateChips2TextField.isVisible = false
    else 
        ChocolateChips1TextField.isVisible = true
        ChocolateChips2TextField.isVisible = true
    end

    if (BakingSodaComplete == true) then
        BakingSoda1TextField.isVisible = false
        BakingSoda2TextField.isVisible = false
    else
        BakingSoda1TextField.isVisible = true
        BakingSoda2TextField.isVisible = true
    end

    if (ButterComplete == true) then
        ButterTextField.isVisible = false
    else
        ButterTextField.isVisible = true
    end

    if (EggsComplete == true) then
        Eggs1TextField.isVisible = false
    else
        Eggs1TextField.isVisible = true
    end

    if (FlourComplete == true) then
        FlourTextField.isVisible = false
    else
        FlourTextField.isVisible = true
    end

    if (VanillaComplete == true) then
        VanillaTextField.isVisible = false
    else
        VanillaTextField.isVisible = true
    end

    if (SaltComplete == true) then
        SaltTextField.isVisible = false
    else
        SaltTextField.isVisible = true
    end

    if (SugarComplete == true) then
        SugarTextField.isVisible = false
    else
        SugarTextField.isVisible = true
    end

end

local function setAnswers(  )
    ANSWERChocolateChips1 = "g"
    ANSWERChocolateChips2 = "r"
    ANSWERBAKINGSODA1 = "g"
    ANSWERBAKINGSODA2 = "a"
    ANSWERBUTTER = "r"
    ANSWEREGGS = "g"
    ANSWERFLOUR = "r"
    ANSWERVanilla = "k"
    ANSWERSALT = "t"
    ANSWERSUGAR = "r"
end
local function youWinTransition( )
    audio.stop(level2SoundChannel)   
    pauseButton.isVisible = false
    timer.cancel(countDownTimer)
    composer.gotoScene( "YouWin", {effect = "slideRight", time = 1000})
end 
local function youLoseTransition(  )
    audio.stop(level2SoundChannel)
    timer.cancel(countDownTimer)
    ChocolateChips1.isVisible = false
    ChocolateChips2.isVisible = false
    BakingSoda1.isVisible = false
    BakingSoda2.isVisible = false
    Butter.isVisible = false
    Eggs1.isVisible = false
    Eggs2.isVisible = false
    Flour.isVisible = false
    Vanilla.isVisible = false
    Salt.isVisible = false
    Sugar.isVisible = false
    ChocolateChips1TextField.isVisible = false
    ChocolateChips2TextField.isVisible = false
    BakingSoda1TextField.isVisible = false
    BakingSoda2TextField.isVisible = false
    ButterTextField.isVisible = false
    Eggs1TextField.isVisible = false
    FlourTextField.isVisible = false
    VanillaTextField.isVisible = false
    SaltTextField.isVisible = false
    SugarTextField.isVisible = false
    pauseButton.isVisible = false
    composer.gotoScene("YouLose", {effect = "slideRight", time = 1000})
end
local function pause(  )
    HideNumTextfields()
    timer.pause(countDownTimer)
    composer.showOverlay( "PauseScreen4", { isModal = true, effect = "fade", time = 100})
end

local function ChocolateChips( )     
    ChocolateChips1.x=ChocolateChips1.x+6
    ChocolateChips1.y = ChocolateChips1.y+2.5
    ChocolateChips1:scale(1.006,1.006)
    ChocolateChips1TextField.x = ChocolateChips1TextField.x + 6.45
    ChocolateChips1TextField.y = ChocolateChips1TextField.y + 2.5
    ChocolateChips1TextField:scale(1.006,1.006)
    ChocolateChips2.x=ChocolateChips2.x+6.87
    ChocolateChips2.y = ChocolateChips2.y + 2.5
    ChocolateChips2:scale(1.006,1.006)
    ChocolateChips2TextField.x = ChocolateChips2TextField.x + 7.3
    ChocolateChips2TextField.y = ChocolateChips2TextField.y + 2.5
    ChocolateChips2TextField:scale(1.006,1.006)
    if (ChocolateChips1.x >= display.contentCenterX) then
       ChocolateChips1TextField:resizeFontToFitHeight()
       ChocolateChips2TextField:resizeFontToFitHeight()
       timer.cancel(ChocolateChipstimer)       
    else
        ChocolateChipstimer = timer.performWithDelay(-0.1,ChocolateChips)  
    end
end

local function BakingSoda( )
    BakingSoda1.x = BakingSoda1.x+3
    BakingSoda1.y = BakingSoda1.y+3
    BakingSoda1:scale(1.007,1.007)
    BakingSoda1TextField.x = BakingSoda1TextField.x +3.5
    BakingSoda1TextField.y = BakingSoda1TextField.y + 3
    BakingSoda2.x = BakingSoda2.x+4
    BakingSoda2.y = BakingSoda2.y + 3
    BakingSoda2:scale(1.007,1.007)
    BakingSoda2TextField.x = BakingSoda2TextField.x + 4.5
    BakingSoda2TextField.y = BakingSoda2TextField.y + 3
    BakingSoda2TextField:scale(1.005,1.007)
    BakingSoda1TextField:scale(1.007,1.007)
    if (BakingSoda1.x >= display.contentCenterX)then
        BakingSoda1TextField:resizeFontToFitHeight()
        BakingSoda2TextField:resizeFontToFitHeight()
        timer.cancel(BakingSodaTimer)
    else
        BakingSodaTimer = timer.performWithDelay(-0.01, BakingSoda)        
    end
end
local function Butter1( )
    Butter:removeEventListener("touch", Butter1)
    Butter.x=Butter.x-1
    Butter.y = Butter.y + 2
    Butter:scale(1.005,1.005)
    ButterTextField.x = ButterTextField.x - 0.5
    ButterTextField.y = ButterTextField.y + 2
    ButterTextField:scale(1.005,1.005)
    if(Butter.x == display.contentCenterX)then
        timer.cancel(ButterTimer)
        ButterTextField:resizeFontToFitHeight() 
    else
        ButterTimer = timer.performWithDelay(-0.1, Butter1)
    end
end

local function Eggs( )
    Eggs1:removeEventListener("touch", Eggs)
    Eggs2:removeEventListener("touch", Eggs)
    Eggs1.x=Eggs1.x-1
    Eggs1.y = Eggs1.y+1
    Eggs1:scale(1.002,1.002)
    Eggs1TextField.x = Eggs1TextField.x - 0.9
    Eggs1TextField.y = Eggs1TextField.y +1
    Eggs1TextField:scale(1.002,1.002)
    Eggs2.x = Eggs2.x-0.9
    Eggs2.y = Eggs2.y + 1
    Eggs2:scale(1.002,1.002)
    if(Eggs1.x == display.contentCenterX)then
        timer.cancel(EggsTimer)
        Eggs1TextField:resizeFontToFitHeight()
    else
        EggsTimer = timer.performWithDelay(-0.3,Eggs)
    end
end
local function Flour1( )
    Flour:removeEventListener("touch", Flour1)
    Flour.x=Flour.x-3
    Flour.y = Flour.y + 2
    Flour:scale(1.005,1.005)
    FlourTextField.x = FlourTextField.x-2.6
    FlourTextField.y = FlourTextField.y + 2
    FlourTextField:scale(1.005,1.005)
    if(Flour.x == display.contentCenterX)then
        timer.cancel(FlourTimer)
        FlourTextField:resizeFontToFitHeight()
    else
        FlourTimer = timer.performWithDelay(-0.1,Flour1)
    end
end

local function Vanilla1( )
    Vanilla:removeEventListener("touch", Vanilla1)
    Vanilla.x=Vanilla.x-4.5
    Vanilla.y = Vanilla.y + 2
    Vanilla:scale(1.005,1.005)
    VanillaTextField.x = VanillaTextField.x - 4
    VanillaTextField.y = VanillaTextField.y + 2
    VanillaTextField:scale(1.005,1.005)
    if(Vanilla.x <= display.contentCenterX)then
        timer.cancel(VanillaTimer)
        VanillaTextField:resizeFontToFitHeight()
    else
        VanillaTimer = timer.performWithDelay(-0.23, Vanilla1)
    end
end
local function Salt1( )
    Salt:removeEventListener("touch", Salt1)
    Salt.x=Salt.x+4
    Salt.y = Salt.y + 1.5
    Salt:scale(1.0015,1.0015)
    SaltTextField.x = SaltTextField.x + 4.10
    SaltTextField.y = SaltTextField.y + 1.5
    SaltTextField:scale(1.0015,1.0015)
    if(Salt.x >= display.contentCenterX)then
        timer.cancel(SaltTimer)
        SaltTextField:resizeFontToFitHeight()
    else
        SaltTimer = timer.performWithDelay(-0.3, Salt1)
    end
end
local function Sugar1( )
    Sugar:removeEventListener("touch", Sugar1)
    Sugar.x=Sugar.x+4
    Sugar.y = Sugar.y+2
    Sugar:scale(1.0015,1.0015)
    SugarTextField.x = SugarTextField.x+4.1
    SugarTextField.y = SugarTextField.y + 2
    SugarTextField:scale(1.0015,1.0015)
    if(Sugar.x == display.contentCenterX)then
        timer.cancel(SugarTimer)
        SugarTextField:resizeFontToFitHeight()
    else
        SugarTimer = timer.performWithDelay(-0.3, Sugar1)
    end
end

local function chooseRandomIng(  )
    print(""..totalIngredients)
    if (pauseinstructions == false) then
       randomIng = math.random(1,8)
       if (randomIng == 1) then
        if (ChocolateChipsComplete == true) then
            while (randomIng == 1) do
                randomIng = math.random( 1,8 )
            end
            if (randomIng ~= 1) then
                chooseRandomIng()
            end
        else
            ChocolateChips()
        end
       elseif (randomIng == 2) then
        if (BakingSodaComplete == true) then
            while (randomIng == 2) do
                randomIng = math.random( 1,8 )
            end
            if (randomIng ~= 2) then
                chooseRandomIng()
            end
        else
            BakingSoda()
        end
       elseif (randomIng == 3 ) then
        if (ButterComplete == true) then
            while (randomIng == 3) do
                randomIng = math.random( 1,8 )
            end
            if (randomIng ~= 3) then
                chooseRandomIng()
            end
        else
            Butter1()
        end
       elseif (randomIng == 4) then
        if (EggsComplete == true) then
            while (randomIng == 4) do
                randomIng = math.random( 1,8 )
            end
            if (randomIng ~= 4) then
                chooseRandomIng()
            end
        else
            Eggs()
        end
       elseif (randomIng == 5) then
        if (FlourComplete == true) then
            while (randomIng == 5) do 
                randomIng = math.random( 1,8 )
            end
            if (randomIng ~= 5) then
                chooseRandomIng()
            end
        else
            Flour1()
        end
       elseif (randomIng == 6) then
        if (VanillaComplete == true) then
            while (randomIng == 6) do
                randomIng = math.random( 1,8 )
            end
            if (randomIng ~= 6) then
                chooseRandomIng()
            end
        else
            Vanilla1()
        end
       elseif (randomIng == 7) then
        if (SaltComplete == true) then
            while (randomIng == 7) do
                randomIng = math.random( 1,8 )
            end
            if (randomIng ~= 7) then
                chooseRandomIng()
            end
        else
            Salt1()
        end
        elseif (randomIng == 8) then
        if (SugarComplete == true) then
            while (randomIng == 8) do
                randomIng = math.random ( 1,8 )
            end
            if (randomIng ~= 8) then
                chooseRandomIng()
            end
        else
            Sugar1()
        end
        end
    end
end

local function checkifwon( )
    if (totalIngredients == 8) then
        youWinTransition()
    else
        chooseRandomIng()
    end
end

local function DissapearChocolateChips( touch )
    if (touch.phase == "moved") then
        
        ChocolateChipsImage.x = touch.x
        ChocolateChipsImage.y = touch.y
    -- this occurs when they release the mouse
    elseif (touch.phase == "ended") then
          -- if the number is dragged into the userAnswerBox, place it in the center of it
        if (((Bowl.x - Bowl.width/2) < ChocolateChipsImage.x ) and
            ((Bowl.x + Bowl.width/2) > ChocolateChipsImage.x ) and 
            ((Bowl.y - Bowl.height/2) < ChocolateChipsImage.y ) and 
            ((Bowl.y + Bowl.height/2) > ChocolateChipsImage.y ) ) then
            ChocolateChipsImage.x = Bowl.x 
            ChocolateChipsImage.y = Bowl.y
            ChocolateChipsImage.isVisible = false
            totalIngredients = totalIngredients + 1
            checkifwon()
        end
    end
end

local function DissapearBakingSoda( touch )
    if (touch.phase == "moved") then
        
        BakingSodaImage.x = touch.x
        BakingSodaImage.y = touch.y
    -- this occurs when they release the mouse
    elseif (touch.phase == "ended") then
          -- if the number is dragged into the userAnswerBox, place it in the center of it
        if (((Bowl.x - Bowl.width/2) < BakingSodaImage.x ) and
            ((Bowl.x + Bowl.width/2) > BakingSodaImage.x ) and 
            ((Bowl.y - Bowl.height/2) < BakingSodaImage.y ) and 
            ((Bowl.y + Bowl.height/2) > BakingSodaImage.y ) ) then
            BakingSodaImage.x = Bowl.x 
            BakingSodaImage.y = Bowl.y
            BakingSodaImage.isVisible = false
            totalIngredients = totalIngredients + 1
            checkifwon()
        end
    end
end

local function DissapearButter( touch )
    if (touch.phase == "moved") then
        
        ButterImage.x = touch.x
        ButterImage.y = touch.y
    -- this occurs when they release the mouse
    elseif (touch.phase == "ended") then
          -- if the number is dragged into the userAnswerBox, place it in the center of it
        if (((Bowl.x - Bowl.width/2) < ButterImage.x ) and
            ((Bowl.x + Bowl.width/2) > ButterImage.x ) and 
            ((Bowl.y - Bowl.height/2) < ButterImage.y ) and 
            ((Bowl.y + Bowl.height/2) > ButterImage.y ) ) then
            ButterImage.x = Bowl.x 
            ButterImage.y = Bowl.y
            ButterImage.isVisible = false
            totalIngredients = totalIngredients + 1
            checkifwon()
        end
    end
end

local function DissapearEggs( touch )
    if (touch.phase == "moved") then
        
        EggsImage.x = touch.x
        EggsImage.y = touch.y
    -- this occurs when they release the mouse
    elseif (touch.phase == "ended") then
          -- if the number is dragged into the userAnswerBox, place it in the center of it
        if (((Bowl.x - Bowl.width/2) < EggsImage.x ) and
            ((Bowl.x + Bowl.width/2) > EggsImage.x ) and 
            ((Bowl.y - Bowl.height/2) < EggsImage.y ) and 
            ((Bowl.y + Bowl.height/2) > EggsImage.y ) ) then
            EggsImage.x = Bowl.x 
            EggsImage.y = Bowl.y
            EggsImage.isVisible = false
            totalIngredients = totalIngredients + 1
            checkifwon()
        end
    end
end

local function DissapearFlour( touch )
    if (touch.phase == "moved") then
        
        FlourImage.x = touch.x
        FlourImage.y = touch.y
    -- this occurs when they release the mouse
    elseif (touch.phase == "ended") then
          -- if the number is dragged into the userAnswerBox, place it in the center of it
        if (((Bowl.x - Bowl.width/2) < FlourImage.x ) and
            ((Bowl.x + Bowl.width/2) > FlourImage.x ) and 
            ((Bowl.y - Bowl.height/2) < FlourImage.y ) and 
            ((Bowl.y + Bowl.height/2) > FlourImage.y ) ) then
            FlourImage.x = Bowl.x 
            FlourImage.y = Bowl.y
            FlourImage.isVisible = false
            totalIngredients = totalIngredients + 1
            checkifwon()
        end
    end
end

local function DissapearVanilla( touch )
    if (touch.phase == "moved") then
        
        VanillaImage.x = touch.x
        VanillaImage.y = touch.y
    -- this occurs when they release the mouse
    elseif (touch.phase == "ended") then
          -- if the number is dragged into the userAnswerBox, place it in the center of it
        if (((Bowl.x - Bowl.width/2) < VanillaImage.x ) and
            ((Bowl.x + Bowl.width/2) > VanillaImage.x ) and 
            ((Bowl.y - Bowl.height/2) < VanillaImage.y ) and 
            ((Bowl.y + Bowl.height/2) > VanillaImage.y ) ) then
            VanillaImage.x = Bowl.x 
            VanillaImage.y = Bowl.y
            VanillaImage.isVisible = false
            totalIngredients = totalIngredients + 1
            checkifwon()
        end
    end
end

local function DissapearSalt( touch )
    if (touch.phase == "moved") then
        
        SaltImage.x = touch.x
        SaltImage.y = touch.y
    -- this occurs when they release the mouse
    elseif (touch.phase == "ended") then
          -- if the number is dragged into the userAnswerBox, place it in the center of it
        if (((Bowl.x - Bowl.width/2) < SaltImage.x ) and
            ((Bowl.x + Bowl.width/2) > SaltImage.x ) and 
            ((Bowl.y - Bowl.height/2) < SaltImage.y ) and 
            ((Bowl.y + Bowl.height/2) > SaltImage.y ) ) then
            SaltImage.x = Bowl.x 
            SaltImage.y = Bowl.y
            SaltImage.isVisible = false
            totalIngredients = totalIngredients + 1
            checkifwon()
        end
    end
end

local function DissapearSugar( touch )
    if (touch.phase == "moved") then
        SugarImage.x = touch.x
        SugarImage.y = touch.y
    -- this occurs when they release the mouse
    elseif (touch.phase == "ended") then
          -- if the number is dragged into the userAnswerBox, place it in the center of it
        if (((Bowl.x - Bowl.width/2) < SugarImage.x ) and
            ((Bowl.x + Bowl.width/2) > SugarImage.x ) and 
            ((Bowl.y - Bowl.height/2) < SugarImage.y ) and 
            ((Bowl.y + Bowl.height/2) > SugarImage.y ) ) then
            SugarImage.x = Bowl.x 
            SugarImage.y = Bowl.y
            SugarImage.isVisible = false
            totalIngredients = totalIngredients + 1
            checkifwon()
        end
    end
end
local function incorrectcorrectObjectinvisible(  )
    -- hide the correct and incorrect objects
    incorrectTextObject.isVisible = false
    correctObject.isVisible = false
end

local function checkAnswers(  )
    lives = lives-1
    if(lives==3)then
        heart3.isVisible=false
    elseif(lives==2) then
        heart2.isVisible=false
    elseif(lives==1)then
        heart1.isVisible=false
        youLoseTransition()
    end    
end

local function PlaceChocolateChips()
    ChocolateChipsComplete = true
    ChocolateChipsImage.x = math.random(100, display.contentWidth)
    ChocolateChipsImage.y = math.random(160, display.contentHeight*330/512)
    while (ChocolateChipsImage.x == pauseButton.x ) do
        ChocolateChipsImage.x = math.random(100, display.contentWidth)
    end
    ChocolateChipsImage.isVisible = true
end

local function ChocolateChips1Q( event )
    userAnswerChocolateChips1 = tostring(event.target.text)
    if(event.phase=="submitted")then
        if (userAnswerChocolateChips2 == ANSWERChocolateChips2) or (userAnswerChocolateChips2 == CAPITOLANSWERChocolateChips2) and (userAnswerChocolateChips1 == ANSWERChocolateChips1)  or (CAPITALANSWERChocolateChips1)then
            ChocolateChips1TextField:removeEventListener("userInput", ChocolateChips1Q)
            ChocolateChips2TextField:removeEventListener("userInput", ChocolateChips2Q)
            native.setKeyboardFocus( nil )
            correctObject.isVisible = true
            if (soundOn == true) then
                correctSoundChannel = audio.play(correctsound)
            end
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            incorrectTextObject.isVisible = false
            ChocolateChips1TextField.text = ""
            ChocolateChips2TextField.text = ""
            BakingSodaV = true
            ChocolateChips1.isVisible = false
            ChocolateChips1TextField.isVisible = false
            ChocolateChips2.isVisible = false
            ChocolateChips2TextField.isVisible = false
            PlaceChocolateChips()
            ChocolateChipsImage:addEventListener("touch", DissapearChocolateChips)
        else
            checkAnswers()
            native.setKeyboardFocus( nil )
            incorrectTextObject.isVisible = true
            if (soundOn == true) then
                incorrectSoundChannel = audio.play(incorrectSound)
            end
            incorrectTextObject.text = ("That is incorrect.You Lose a life")
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            correctObject.isVisible = false
            BakingSodaV = true
        end
    end
end

local function ChocolateChips2Q( event )
        userAnswerChocolateChips2 = tostring(event.target.text)
    if(event.phase=="submitted")then
        if (userAnswerChocolateChips2 == ANSWERChocolateChips2) or (userAnswerChocolateChips2 == CAPITOLANSWERChocolateChips2) and (userAnswerChocolateChips1 == ANSWERChocolateChips1) or (userAnswerChocolateChips1 == CAPITALANSWERChocolateChips1)then
            native.setKeyboardFocus( nil )
            ChocolateChips1TextField:removeEventListener("userInput", ChocolateChips1Q)
            ChocolateChips2TextField:removeEventListener("userInput", ChocolateChips2Q)
            correctObject.isVisible = true
            if (soundOn == true) then
                correctSoundChannel = audio.play(correctSound)
            end
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            incorrectTextObject.isVisible = false
            ChocolateChips1TextField.text = ""
            ChocolateChips2TextField.text = ""
            BakingSodaV = true
            ChocolateChips1.isVisible = false
            ChocolateChips1TextField.isVisible = false
            ChocolateChips2.isVisible = false
            ChocolateChips2TextField.isVisible = false
            PlaceChocolateChips()
            ChocolateChipsImage:addEventListener("touch", DissapearChocolateChips)
        else
            checkAnswers()
            native.setKeyboardFocus( nil )
            incorrectTextObject.isVisible = true
            if (soundOn == true) then
                incorrectSoundChannel = audio.play(incorrectSound)
            end
            incorrectTextObject.text = ("That is incorrect.You Lose a life")
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            correctObject.isVisible = false
            BakingSodaV = true
        end
    end
end

local function PlaceBakingSoda()
    BakingSodaComplete = true
    BakingSodaImage.x = math.random(100, display.contentWidth)
    BakingSodaImage.y = math.random(160, display.contentHeight*330/512)
    while (BakingSodaImage.x == pauseButton.x ) do
        BakingSodaImage.x = math.random(100, display.contentWidth)
    end
    BakingSodaImage.isVisible = true
end

local function BakingSoda1Q( event )

    userAnswerBakingSoda1 = tostring(event.target.text)     
    if(event.phase=="submitted")then
        userAnswerBakingSoda2 = tostring(event.target.text)
        if (userAnswerBakingSoda1 == ANSWERBAKINGSODA1) or (userAnswerBakingSoda1 == CAPITOLANSWERBAKINGSODA1)and (userAnswerBakingSoda2 == ANSWERBAKINGSODA2) or (userAnswerBakingSoda2 == CAPITOLANSWERBAKINGSODA2)then
            native.setKeyboardFocus( nil )
            BakingSoda1TextField:removeEventListener("userInput", BakingSoda1Q)
            BakingSoda2TextField:removeEventListener("userInput", BakingSoda2Q)
            correctObject.isVisible = true
            if (soundOn == true) then
                correctSoundChannel = audio.play(correctSound)
            end
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            incorrectTextObject.isVisible = false
            BakingSodaV = false
            ButterV = true
            BakingSoda1TextField.text = ""
            BakingSoda2TextField.text = ""
            BakingSoda1.isVisible = false
            BakingSoda1TextField.isVisible = false
            BakingSoda2.isVisible = false
            BakingSoda2TextField.isVisible = false
            PlaceBakingSoda()
            BakingSodaImage:addEventListener("touch", DissapearBakingSoda)

        else
            native.setKeyboardFocus( nil )
            checkAnswers()
            incorrectTextObject.isVisible = true
            if (soundOn == true) then
                incorrectSoundChannel = audio.play(incorrectSound)
            end
            incorrectTextObject.text = ("That is incorrect.You Lose a life. Try again")
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            correctObject.isVisible = false
            BakingSodaV = false
            ButterV = true
        end
    end
end

local function BakingSoda2Q( event )
    -- ask the question
    if (event.phase=="began")then

        --clear text field 
       BakingSoda2TextField.text=""
       
    elseif(event.phase=="submitted")then
        userAnswerBakingSoda2 = tostring(event.target.text)
        if (userAnswerBakingSoda1 == ANSWERBAKINGSODA1) or (userAnswerBakingSoda1 == CAPITOLANSWERBAKINGSODA1)and (userAnswerBakingSoda2 == ANSWERBAKINGSODA2) or (userAnswerBakingSoda2 == CAPITOLANSWERBAKINGSODA2)then
            native.setKeyboardFocus( nil )
            BakingSoda1TextField:removeEventListener("userInput", BakingSoda1Q)
            BakingSoda2TextField:removeEventListener("userInput", BakingSoda2Q)
            correctObject.isVisible = true
            if (soundOn == true) then
                correctSoundChannel = audio.play(correctSound)
            end
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            incorrectTextObject.isVisible = false
            BakingSodaV = false
            ButterV = true
            BakingSoda1TextField.text = ""
            BakingSoda2TextField.text = ""
            BakingSoda1.isVisible = false
            BakingSoda1TextField.isVisible = false
            BakingSoda2.isVisible = false
            BakingSoda2TextField.isVisible = false
            PlaceBakingSoda()
            BakingSodaImage:addEventListener("touch", DissapearBakingSoda)

        else
            native.setKeyboardFocus( nil )
            checkAnswers()
            incorrectTextObject.isVisible = true
            if (soundOn == true) then
                incorrectSoundChannel = audio.play(incorrectSound)
            end
            incorrectTextObject.text = ("That is incorrect.You Lose a life. Try again")
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            correctObject.isVisible = false
            BakingSodaV = false
            ButterV = true
        end
    end
end

local function PlaceButter()
    ButterComplete = true
    ButterImage.x = math.random(100, display.contentWidth)
    ButterImage.y = math.random(160, display.contentHeight*330/512)
    while (ButterImage.x == pauseButton.x ) do
        ButterImage.x = math.random(100, display.contentWidth)
    end
    ButterImage.isVisible = true
end

local function ButterQ( event )
    -- ask the question
    if (event.phase=="began")then

        --clear text field 
       ButterTextField.text=""
    elseif(event.phase=="submitted")then
        userAnswerButter = tostring(event.target.text)
        if (userAnswerButter == ANSWERBUTTER) or (userAnswerButter == CAPITOLANSWERBUTTER)then
            native.setKeyboardFocus( nil )
            ButterTextField:removeEventListener("userInput", ButterQ)
            correctObject.isVisible = true
            if (soundOn == true) then
                correctSoundChannel = audio.play(correctSound)
            end
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            incorrectTextObject.isVisible = false
            ButterV = false
            EggsV = true
            ButterTextField.text = ""
            Butter.isVisible = false
            ButterTextField.isVisible = false
            PlaceButter()
            ButterImage:addEventListener("touch", DissapearButter)
            
        else
            native.setKeyboardFocus( nil )
            checkAnswers()
            incorrectTextObject.isVisible = true
            if (soundOn == true) then
                incorrectSoundChannel = audio.play(incorrectSound)
            end
            incorrectTextObject.text = ("That is incorrect.You Lose a life. Try again")
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            correctObject.isVisible = false
            ButterV = false
            EggsV = true
            ButterTextField.text = ""
        end
    end
end

local function PlaceEggs()
    EggsComplete = true
    EggsImage.x = math.random(100, display.contentWidth)
    EggsImage.y = math.random(160, display.contentHeight*330/512)
    while (EggsImage.x == pauseButton.x ) do
        EggsImage.x = math.random(100, display.contentWidth)
    end
    EggsImage.isVisible = true
end

local function EggsQ( event )
    -- ask the question
    if (event.phase=="began")then

        --clear text field 
       Eggs1TextField.text=""
    elseif(event.phase=="submitted")then
        userAnswerEggs = tostring(event.target.text)
        if (userAnswerEggs == ANSWEREGGS)then
            native.setKeyboardFocus( nil )
            Eggs1TextField:removeEventListener("userInput", EggsQ)        
            correctObject.isVisible = true
            if (soundOn == true) then
                correctSoundChannel = audio.play(correctSound)
            end
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            incorrectTextObject.isVisible = false
            EggsV = false
            FlourV = true
            Eggs1TextField.isVisible = false
            Eggs1.isVisible = false
            Eggs2.isVisible = false
            PlaceEggs()
            EggsImage:addEventListener("touch", DissapearEggs)
        else
            native.setKeyboardFocus( nil )
            checkAnswers()
            incorrectTextObject.isVisible = true
            if (soundOn == true) then
                incorrectSoundChannel = audio.play(incorrectSound)
            end
            incorrectTextObject.text = ("That is incorrect.You Lose a life. Try again")
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            correctObject.isVisible = false
            Eggs1TextField.text = ""
            EggsV = false
            FlourV = true
        end
    end
end

local function PlaceFlour()
    FlourComplete = true
    FlourImage.x = math.random(100, display.contentWidth)
    FlourImage.y = math.random(160, display.contentHeight*330/512)
    while (FlourImage.x == pauseButton.x ) do
        FlourImage.x = math.random(100, display.contentWidth)
    end
    FlourImage.isVisible = true
end

local function FlourQ( event )
    -- ask the question
    if (event.phase=="began")then

        --clear text field 
       FlourTextField.text=""
    elseif(event.phase=="submitted")then
        userAnswerFlour = tostring(event.target.text)
        if (userAnswerFlour == ANSWERFLOUR)then
            native.setKeyboardFocus( nil )
            FlourTextField:removeEventListener("userInput", FlourQ)
            correctObject.isVisible = true
            if (soundOn == true) then
                correctSoundChannel = audio.play(correctSound)
            end
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            incorrectTextObject.isVisible = false
            FlourTextField.text = ""
            FlourV = false
            VanillaV = true
            Flour.isVisible = false
            FlourTextField.isVisible = false
            PlaceFlour()
            FlourImage:addEventListener("touch", DissapearFlour)
        else
            native.setKeyboardFocus( nil )
            checkAnswers()
            incorrectTextObject.isVisible = true
            if (soundOn == true) then
                incorrectSoundChannel = audio.play(incorrectSound)
            end
            incorrectTextObject.text = ("That is incorrect.You Lose a life. Try again")
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            correctObject.isVisible = false
            FlourTextField.text = ""
            FlourV = false
            VanillaV = true

        end
    end
end

local function PlaceVanilla()
    VanillaComplete = true
    VanillaImage.x = math.random(100, display.contentWidth)
    VanillaImage.y = math.random(160, display.contentHeight*330/512)
    while (VanillaImage.x == pauseButton.x ) do
        VanillaImage.x = math.random(100, display.contentWidth)
    end
    VanillaImage.isVisible = true
end

local function VanillaQ( event )
    -- ask the question
    if (event.phase=="began")then

        --clear text field 
       VanillaTextField.text=""
    elseif(event.phase=="submitted")then
        userAnswerVanilla = tostring(event.target.text)
        if (userAnswerVanilla == ANSWERVanilla)then
            native.setKeyboardFocus( nil )
            VanillaTextField:removeEventListener("userInput", VanillaQ)
            correctObject.isVisible = true
            if (soundOn == true ) then 
                correctSoundChannel = audio.play(correctSound)
            end
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            incorrectTextObject.isVisible = false
            VanillaTextField.isVisible = false
            Vanilla.isVisible = false
            SaltV = true
            VanillaV = false
            PlaceVanilla()
            VanillaImage:addEventListener("touch", DissapearVanilla)
            
        else
            native.setKeyboardFocus( nil )
            checkAnswers()
            incorrectTextObject.isVisible = true
            if (soundOn == true) then
                incorrectSoundChannel = audio.play(incorrectSound)
            end
            incorrectTextObject.text = ("That is incorrect.You Lose a life. Try again")
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            correctObject.isVisible = false
            VanillaTextField.text = ""
            VanillaV = false
            SaltV = true
        end
    end
end

local function PlaceSalt()
    SaltImage.isVisible = true
    SaltComplete = true
    SaltImage.x = math.random(100, display.contentWidth)
    SaltImage.y = math.random(160, display.contentHeight*330/512)
    while (SaltImage.x == pauseButton.x ) do
        SaltImage.x = math.random(100, display.contentWidth)
    end
end

local function SaltQ( event )
    -- ask the question
    if (event.phase=="began")then

        --clear text field 
       SaltTextField.text=""
    elseif(event.phase=="submitted")then
        userAnswerSalt = tostring(event.target.text)
        if (userAnswerSalt == ANSWERSALT)then
            native.setKeyboardFocus( nil )
            SaltTextField:removeEventListener("userInput", SaltQ)
            correctObject.isVisible = true
            if (soundOn == true) then
                correctSoundChannel = audio.play(correctSound)
            end
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            incorrectTextObject.isVisible = false
            SaltTextField.isVisible = false
            Salt.isVisible = false 
            SaltV = false
            SugarV = true
            PlaceSalt()
            SaltImage:addEventListener("touch", DissapearSalt)
        else
            native.setKeyboardFocus( nil )
            checkAnswers()
            incorrectTextObject.isVisible = true
            if (soundOn == true) then
                incorrectSoundChannel = audio.play(incorrectSound)
            end
            incorrectTextObject.text = ("That is incorrect.You Lose a life. Try again")
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            correctObject.isVisible = false
            SaltTextField.text = ""
            SaltV = false
            SugarV = true
        end
    end
end

local function PlaceSugar()
    SugarImage.isVisible = true
    SugarComplete = true
    SugarImage.x = math.random(100, display.contentWidth)
    SugarImage.y = math.random(160, display.contentHeight*330/512)
    while (SugarImage.x == pauseButton.x ) do
        SugarImage.x = math.random(100, display.contentWidth)
    end
    
end

local function SugarQ( event )
    -- ask the question
    if (event.phase=="began")then

        --clear text field 
       SugarTextField.text=""
    elseif(event.phase=="submitted")then
        userAnswerSugar = tostring(event.target.text)
        if (userAnswerSugar == ANSWERSUGAR)then
            native.setKeyboardFocus( nil )
            SugarTextField:removeEventListener("userInput", SugarQ)
            correctObject.isVisible = true
            if (soundOn == true) then
                correctSoundChannel = audio.play(correctSound)
            end
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            incorrectTextObject.isVisible = false
            SugarTextField.isVisible = false
            Sugar.isVisible = false
            SugarV = false
            PlaceSugar()
            SugarImage:addEventListener("touch", DissapearSugar)
        else
            native.setKeyboardFocus( nil )
            checkAnswers()
            incorrectTextObject.isVisible = true
            if (soundOn == true) then
                incorrectSoundChannel = audio.play(incorrectSound)
            end
            incorrectTextObject.text = ("That is incorrect.You Lose a life. Try again")
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            correctObject.isVisible = false
            SugarTextField.text = ""
            SugarV = false
        end
    end
end

local function Updatetime()
    -- decrement the number of seconds
    secondsleft = secondsleft-1
    --display the number of seconds in a clock 
    clockText.text=secondsleft..""
    if (secondsleft == 0) then
        secondsleft=totalseconds
        incorrectTextObject.isVisible=true
        incorrectTextObject.text=("You ran out of time :(.You lose a life")
        timer.performWithDelay(5000, incorrectcorrectObjectinvisible)
        checkAnswers()
    end    
end

--call the timer
local function StartTimer()
    if (pauseinstructions == false) then
        secondsleft = totalseconds
        countDownTimer = timer.performWithDelay(1000, Updatetime, 0)
    else
        countDownTimer = timer.performWithDelay( 1000, Updatetime, 0)
    end
end

local function AddEventListeners()
    pauseButton:addEventListener("touch", pause)
    ChocolateChips1TextField:addEventListener("userInput", ChocolateChips1Q)
    ChocolateChips2TextField:addEventListener("userInput", ChocolateChips2Q)
    BakingSoda1TextField:addEventListener("userInput", BakingSoda1Q)
    BakingSoda2TextField:addEventListener("userInput", BakingSoda2Q)
    ButterTextField:addEventListener("userInput", ButterQ)
    Eggs1TextField:addEventListener("userInput", EggsQ)
    FlourTextField:addEventListener("userInput", FlourQ)
    VanillaTextField:addEventListener("userInput", VanillaQ)
    SaltTextField:addEventListener("userInput", SaltQ)
    SugarTextField:addEventListener("userInput", SugarQ)
end
   
local function create(  )
        -- Insert the background image
    bkg = display.newImageRect("Images/level4screen.png", display.contentWidth, display.contentHeight)
    bkg.x = display.contentCenterX
    bkg.y = display.contentCenterY
    bkg.width = display.contentWidth
    bkg.height = display.contentHeight
        -- Insert background image into the scene group in order to ONLY be associated with this scene
     
    -- insert first ingredient 


    ChocolateChips1 = display.newText("Choc ", 50 ,110, Arial, 35)
    ChocolateChips1:setTextColor(0,0,0)  

    ChocolateChips1TextField = native.newTextField(105 , 110 , 30 , 35)
    ChocolateChips1TextField.inputType = "no-emoji"
    ChocolateChips1TextField:setTextColor(0,0.3,0) 
    
    ChocolateChips2 = display.newText("l    te", 160 , 110 , Arial , 35)
    ChocolateChips2:setTextColor(0,0,0)  

    ChocolateChips2TextField = native.newTextField(145, 110 , 30 , 35)
    ChocolateChips2TextField:setTextColor(0,0.3,0)
    ChocolateChips2TextField.inputType = "no-emoji"

    ChocolateChips3 = display.newText("Ch   ps", 280 , 110 , Arial , 35)
    ChocolateChips3:setTextColor(0,0,0)  

    ChocolateChips3TextField = native.newTextField(285, 110 , 30 , 35)
    ChocolateChips3TextField:setTextColor(0,0.3,0)
    ChocolateChips3TextField.inputType = "no-emoji"

    BakingSoda1 = display.newText("Bakin", 340 , 110 , Arial , 35)
    BakingSoda1:setTextColor(0,0,0)
      

    BakingSoda1TextField = native.newTextField(400 , 110 , 30 , 35)
    BakingSoda1TextField:setTextColor(0,0.3,0)
    BakingSoda1TextField.inputType = "no-emoji"

    BakingSoda2 = display.newText("sod", 450 , 110, Arial, 35)
    BakingSoda2:setTextColor(0,0,0)  

    BakingSoda2TextField = native.newTextField(500 , 110 , 30 , 35)
    BakingSoda2TextField:setTextColor(0,0.3,0)
    BakingSoda2TextField.inputType = "no-emoji" 

    Butter = display.newText("Butte", 580, 110, Arial , 35)
    Butter:setTextColor(0,0,0)  

    ButterTextField = native.newTextField(635 , 110, 30 , 35)
    ButterTextField:setTextColor(0,0.3,0)
    ButterTextField.inputType = "no-emoji" 

    Eggs1 = display.newText("Eg", 680, 110, Arial, 35)
    Eggs1:setTextColor(0,0,0)  

    Eggs1TextField = native.newTextField(720, 110, 30, 35)
    Eggs1TextField:setTextColor(0,0.3,0)
    Eggs1TextField.inputType = "no-emoji" 

    Eggs2 = display.newText("s", 750, 110, Arial ,35)
    Eggs2:setTextColor(0,0,0) 

    Flour = display.newText("Flou", 800, 110, Arial, 35)
    Flour:setTextColor(0,0,0) 

    FlourTextField = native.newTextField(850, 110, 30, 35)
    FlourTextField:setTextColor(0,0.3,0)
    FlourTextField.inputType = "no-emoji"

    Vanilla = display.newText("Mil",900, 110, Arial, 35)
    Vanilla:setTextColor(0,0,0)

    VanillaTextField = native.newTextField(940, 110, 30, 35)
    VanillaTextField:setTextColor(0,0.3,0)
    VanillaTextField.inputType = "no-emoji"

    Salt = display.newText("Sal", 30, 150, Arial, 35)
    Salt:setTextColor(0,0,0)

    SaltTextField = native.newTextField(80, 150, 30, 35)
    SaltTextField:setTextColor(0,0.3,0)
    SaltTextField.inputType = "no-emoji"

    Sugar = display.newText("Suga", 140, 150, Arial, 35)
    Sugar:setTextColor(0,0,0)

    SugarTextField = native.newTextField(200, 150, 30, 35)
    SugarTextField:setTextColor(0,0.3,0)
    SugarTextField.inputType = "no-emoji"

    correctObject = display.newText("Hey dude that's correct!", display.contentCenterX,display.contentCenterY*6/10, Arial, 60)
    correctObject:setTextColor(0,0,0)
    correctObject.isVisible = false

    incorrectTextObject = display.newText("Sorry but that's wrong.", display.contentCenterX, display.contentCenterY*6/10, Arial, 40)
    incorrectTextObject:setTextColor(0,0,0)
    incorrectTextObject.isVisible = false

        --create the lives
    heart1=display.newImageRect("Images/heart1.png", 100, 100)
    heart1.x=display.contentWidth*7/11
    heart1.y=display.contentHeight*1/17
    heart1:scale(0.5,0.5)

    heart2=display.newImageRect("Images/heart1.png", 100, 100)
    heart2.x=display.contentWidth*8/11
    heart2.y=display.contentHeight*1/17
    heart2:scale(0.5,0.5)

    heart3=display.newImageRect("Images/heart1.png", 100, 100)
    heart3.x=display.contentWidth*9/11
    heart3.y=display.contentHeight*1/17
    heart3:scale(0.5,0.5)

    clockText=display.newText("60", display.contentWidth/3, display.contentHeight/5, nil, 50)
    clockText:setTextColor(255/255, 2/255, 198/255)
    clockText.isVisible=true

    pauseButton = display.newImageRect("Images/pause button.png", 500,100)
    pauseButton.width = 100
    pauseButton.height = 100
    pauseButton.x = 900
    pauseButton.y = 200

    Bowl = display.newImageRect("Images/BowlNicR.png", 200, 200)
    Bowl.width = 150
    Bowl.height = 100
    Bowl.x = 500
    Bowl.y = 525

    ChocolateChipsImage = display.newImageRect("Images/ChocolateChips.png", 100 , 100)
    ChocolateChipsImage.x = math.random(50, display.contentWidth)
    ChocolateChipsImage.y = math.random(160, display.contentHeight*330/512)
    ChocolateChipsImage.isVisible = false
    
    BakingSodaImage = display.newImageRect("Images/bakingsoda.png", 100,100)
    BakingSodaImage.x = math.random(50, display.contentWidth)
    BakingSodaImage.y = math.random(160, display.contentHeight*330/512)
    BakingSodaImage.isVisible = false

    ButterImage = display.newImageRect("Images/butter.png", 200, 200)
    ButterImage.x = math.random(50, display.contentWidth)
    ButterImage.y = math.random(160, display.contentHeight*330/512)
    ButterImage.isVisible = false

    EggsImage = display.newImageRect("Images/eggs.png", 150, 150)
    EggsImage.x = math.random(50, display.contentWidth)
    EggsImage.y = math.random(160, display.contentHeight*330/512)
    EggsImage.isVisible = false

    FlourImage = display.newImageRect("Images/flour.png", 150, 150)
    FlourImage.isVisible = false

    VanillaImage = display.newImageRect("Images/Vanilla.png", 150, 150)
    VanillaImage.x = math.random(50, display.contentWidth)
    VanillaImage.y = math.random(160, display.contentHeight*330/512)
    VanillaImage.isVisible = false

    SaltImage = display.newImageRect("Images/Salt.png", 200, 200)
    SaltImage.x = math.random(50, display.contentWidth)
    SaltImage.y = math.random(250, display.contentHeight*330/512)
    SaltImage.isVisible = false

    SugarImage = display.newImageRect("Images/sugar.png", 200, 200)
    SugarImage.x = math.random(50, display.contentWidth)
    SugarImage.y = math.random(160, display.contentHeight*330/512)
    SugarImage.isVisible = false
    

end

-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------


function resumeGamelevel2(  )
    setAnswers()
    ShowNumTextfields()
    timer.resume(countDownTimer)
end



-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    create()
    sceneGroup:insert( bkg ) 
    sceneGroup:insert( ChocolateChips1 ) 
    sceneGroup:insert( ChocolateChips1TextField ) 
    sceneGroup:insert( ChocolateChips2 )
    sceneGroup:insert( ChocolateChips2TextField ) 
    sceneGroup:insert( BakingSoda1 ) 
    sceneGroup:insert( BakingSoda1TextField )
    sceneGroup:insert( BakingSoda1TextField )  
    sceneGroup:insert( BakingSoda2 )
    sceneGroup:insert( BakingSoda2TextField ) 
    sceneGroup:insert( Butter )
    sceneGroup:insert( ButterTextField ) 
    sceneGroup:insert( Eggs1 )
    sceneGroup:insert( Eggs1TextField ) 
    sceneGroup:insert( Eggs2 ) 
    sceneGroup:insert( Flour ) 
    sceneGroup:insert( FlourTextField )
    sceneGroup:insert( Vanilla )
    sceneGroup:insert( VanillaTextField )  
    sceneGroup:insert( Salt )
    sceneGroup:insert( SaltTextField )
    sceneGroup:insert( Sugar )
    sceneGroup:insert( SugarTextField )
    sceneGroup:insert(correctObject)
    sceneGroup:insert(incorrectTextObject)
    sceneGroup:insert(heart1)
    sceneGroup:insert(heart2)
    sceneGroup:insert(heart3)
    sceneGroup:insert(clockText)
    sceneGroup:insert( pauseButton )
    sceneGroup:insert(Bowl)
    sceneGroup:insert(ChocolateChipsImage)
    sceneGroup:insert(BakingSodaImage)
    sceneGroup:insert(ButterImage)
    sceneGroup:insert(EggsImage)
    sceneGroup:insert(FlourImage)
    sceneGroup:insert(VanillaImage)
    sceneGroup:insert(SaltImage)
    sceneGroup:insert(SugarImage)

end 
 --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        --composer.removeScene("mainmenu")
        AddEventListeners() 
        if (soundOn == true) then    
            audio.resume(level2SoundChannel)
        else
            audio.pause(level2SoundChannel)
        end
       
        if (pauseinstructions == true) then
            pause()
        end
        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        StartTimer()
        chooseRandomIng()
        

    end
end --function scene:show( event )

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
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

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
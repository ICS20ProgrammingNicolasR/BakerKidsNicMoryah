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
sceneName = "level2_screen"

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
local BakingPowder1
local BakingPowder1TextField
local BakingPowder2
local BakingPowder2TextField
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
local Milk
local MilkTextField
local Salt
local SaltTextField
local Sugar
local SugarTextField
local Bowl
local BakingPowderImage
local BakingSodaImage
local ButterImage
local EggsImage 
local FlourImage
local MilkImage 
local SaltImage 
local SugarImage

local bakingpowdertimer
local BakingSodaTimer
local ButterTimer
local EggsTimer
local MilkTimer
local SaltTimer
local SugarTimer

local ANSWERBAKINGPOWDER1 = "g"
local ANSWERBAKINGPOWDER2 = "r"
local ANSWERBAKINGSODA1 = "g"
local ANSWERBAKINGSODA2 = "a"
local ANSWERBUTTER = "r"
local ANSWEREGGS = "g"
local ANSWERFLOUR = "r"
local ANSWERMILK = "k"
local ANSWERSALT = "t"
local ANSWERSUGAR = "r"

local CAPITALANSWERBAKINGPOWDER1 = "G"
local CAPITOLANSWERBAKINGPOWDER2 = "R"
local CAPITOLANSWERBAKINGSODA1 = "G" 
local CAPITOLANSWERBAKINGSODA2 = "A"
local CAPITOLANSWERBUTTER = "R"
local CAPITOLANSWEREGGS = "G"
local CAPITOLANSWERFLOUR = "R"
local CAPITOLANSWERMILK = "K"
local CAPITOLANSWERSALT = "T"
local CAPITOLANSWERSUGAR = "R"

local userAnswerBakingPowder1
local userAnswerBakingPowder2
local userAnswerBakingSoda1
local userAnswerBakingSoda2
local userAnswerButter
local userAnswerEggs
local userAnswerFlour
local userAnswerMilk
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
local MilkComplete = false
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
    BakingPowder1TextField.isVisible = false
    BakingPowder2TextField.isVisible = false 
    BakingSoda1TextField.isVisible = false
    BakingSoda2TextField.isVisible = false
    ButterTextField.isVisible = false
    Eggs1TextField.isVisible = false
    FlourTextField.isVisible = false
    MilkTextField.isVisible = false
    SaltTextField.isVisible = false
    SugarTextField.isVisible = false

end

local function ShowNumTextfields()

    if (BakingPowerComplete == true) then
        BakingPowder1TextField.isVisible = false
        BakingPowder2TextField.isVisible = false
    else 
        BakingPowder1TextField.isVisible = true
        BakingPowder2TextField.isVisible = true
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

    if (MilkComplete == true) then
        MilkTextField.isVisible = false
    else
        MilkTextField.isVisible = true
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
    ANSWERBAKINGPOWDER1 = "g"
    ANSWERBAKINGPOWDER2 = "r"
    ANSWERBAKINGSODA1 = "g"
    ANSWERBAKINGSODA2 = "a"
    ANSWERBUTTER = "r"
    ANSWEREGGS = "g"
    ANSWERFLOUR = "r"
    ANSWERMILK = "k"
    ANSWERSALT = "t"
    ANSWERSUGAR = "r"
end
local function youWinTransition( )
    audio.stop(level2SoundChannel)   
    pauseButton.isVisible = false
    timer.cancel(countDownTimer)
    composer.gotoScene( "YouWin2", {effect = "slideRight", time = 1000})
end 
local function youLoseTransition(  )
    audio.stop(level2SoundChannel)
    timer.cancel(countDownTimer)
    BakingPowder1.isVisible = false
    BakingPowder2.isVisible = false
    BakingSoda1.isVisible = false
    BakingSoda2.isVisible = false
    Butter.isVisible = false
    Eggs1.isVisible = false
    Eggs2.isVisible = false
    Flour.isVisible = false
    Milk.isVisible = false
    Salt.isVisible = false
    Sugar.isVisible = false
    BakingPowder1TextField.isVisible = false
    BakingPowder2TextField.isVisible = false
    BakingSoda1TextField.isVisible = false
    BakingSoda2TextField.isVisible = false
    ButterTextField.isVisible = false
    Eggs1TextField.isVisible = false
    FlourTextField.isVisible = false
    MilkTextField.isVisible = false
    SaltTextField.isVisible = false
    SugarTextField.isVisible = false
    pauseButton.isVisible = false
    composer.gotoScene("YouLose2", {effect = "slideRight", time = 1000})
end
local function pause(  )
    HideNumTextfields()
    timer.pause(countDownTimer)
    composer.showOverlay( "PauseScreen2", { isModal = true, effect = "fade", time = 100})
end

local function BakingPowder( )     
    BakingPowder1.x=BakingPowder1.x+6
    BakingPowder1.y = BakingPowder1.y+2.5
    BakingPowder1:scale(1.006,1.006)
    BakingPowder1TextField.x = BakingPowder1TextField.x + 6.45
    BakingPowder1TextField.y = BakingPowder1TextField.y + 2.5
    BakingPowder1TextField:scale(1.006,1.006)
    BakingPowder2.x=BakingPowder2.x+6.87
    BakingPowder2.y = BakingPowder2.y + 2.5
    BakingPowder2:scale(1.006,1.006)
    BakingPowder2TextField.x = BakingPowder2TextField.x + 7.3
    BakingPowder2TextField.y = BakingPowder2TextField.y + 2.5
    BakingPowder2TextField:scale(1.006,1.006)
    if (BakingPowder1.x >= display.contentCenterX) then
       BakingPowder1TextField:resizeFontToFitHeight()
       BakingPowder2TextField:resizeFontToFitHeight()
       timer.cancel(bakingpowdertimer)       
    else
        bakingpowdertimer = timer.performWithDelay(-0.1,BakingPowder)  
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

local function Milk1( )
    Milk:removeEventListener("touch", Milk1)
    Milk.x=Milk.x-4.5
    Milk.y = Milk.y + 2
    Milk:scale(1.005,1.005)
    MilkTextField.x = MilkTextField.x - 4
    MilkTextField.y = MilkTextField.y + 2
    MilkTextField:scale(1.005,1.005)
    if(Milk.x <= display.contentCenterX)then
        timer.cancel(MilkTimer)
        MilkTextField:resizeFontToFitHeight()
    else
        MilkTimer = timer.performWithDelay(-0.23, Milk1)
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
        if (BakingPowderComplete == true) then
            while (randomIng == 1) do
                randomIng = math.random( 1,8 )
            end
            if (randomIng ~= 1) then
                chooseRandomIng()
            end
        else
            BakingPowder()
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
        if (MilkComplete == true) then
            while (randomIng == 6) do
                randomIng = math.random( 1,8 )
            end
            if (randomIng ~= 6) then
                chooseRandomIng()
            end
        else
            Milk1()
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

local function DissapearBakingPowder( touch )
    if (touch.phase == "moved") then
        
        BakingPowderImage.x = touch.x
        BakingPowderImage.y = touch.y
    -- this occurs when they release the mouse
    elseif (touch.phase == "ended") then
          -- if the number is dragged into the userAnswerBox, place it in the center of it
        if (((Bowl.x - Bowl.width/2) < BakingPowderImage.x ) and
            ((Bowl.x + Bowl.width/2) > BakingPowderImage.x ) and 
            ((Bowl.y - Bowl.height/2) < BakingPowderImage.y ) and 
            ((Bowl.y + Bowl.height/2) > BakingPowderImage.y ) ) then
            BakingPowderImage.x = Bowl.x 
            BakingPowderImage.y = Bowl.y
            BakingPowderImage.isVisible = false
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

local function DissapearMilk( touch )
    if (touch.phase == "moved") then
        
        MilkImage.x = touch.x
        MilkImage.y = touch.y
    -- this occurs when they release the mouse
    elseif (touch.phase == "ended") then
          -- if the number is dragged into the userAnswerBox, place it in the center of it
        if (((Bowl.x - Bowl.width/2) < MilkImage.x ) and
            ((Bowl.x + Bowl.width/2) > MilkImage.x ) and 
            ((Bowl.y - Bowl.height/2) < MilkImage.y ) and 
            ((Bowl.y + Bowl.height/2) > MilkImage.y ) ) then
            MilkImage.x = Bowl.x 
            MilkImage.y = Bowl.y
            MilkImage.isVisible = false
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

local function PlaceBakingPowder()
    BakingPowderComplete = true
    BakingPowderImage.x = math.random(100, display.contentWidth)
    BakingPowderImage.y = math.random(160, display.contentHeight*330/512)
    while (BakingPowderImage.x == pauseButton.x ) do
        BakingPowderImage.x = math.random(100, display.contentWidth)
    end
    BakingPowderImage.isVisible = true
end

local function BakingPowder1Q( event )
    userAnswerBakingPowder1 = tostring(event.target.text)
    if(event.phase=="submitted")then
        if (userAnswerBakingPowder2 == ANSWERBAKINGPOWDER2) or (userAnswerBakingPowder2 == CAPITOLANSWERBAKINGPOWDER2) and (userAnswerBakingPowder1 == ANSWERBAKINGPOWDER1)  or (CAPITALANSWERBAKINGPOWDER1)then
            BakingPowder1TextField:removeEventListener("userInput", BakingPowder1Q)
            BakingPowder2TextField:removeEventListener("userInput", BakingPowder2Q)
            native.setKeyboardFocus( nil )
            correctObject.isVisible = true
            if (soundOn == true) then
                correctSoundChannel = audio.play(correctsound)
            end
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            incorrectTextObject.isVisible = false
            BakingPowder1TextField.text = ""
            BakingPowder2TextField.text = ""
            BakingSodaV = true
            BakingPowder1.isVisible = false
            BakingPowder1TextField.isVisible = false
            BakingPowder2.isVisible = false
            BakingPowder2TextField.isVisible = false
            PlaceBakingPowder()
            BakingPowderImage:addEventListener("touch", DissapearBakingPowder)
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

local function BakingPowder2Q( event )
        userAnswerBakingPowder2 = tostring(event.target.text)
    if(event.phase=="submitted")then
        if (userAnswerBakingPowder2 == ANSWERBAKINGPOWDER2) or (userAnswerBakingPowder2 == CAPITOLANSWERBAKINGPOWDER2) and (userAnswerBakingPowder1 == ANSWERBAKINGPOWDER1) or (userAnswerBakingPowder1 == CAPITALANSWERBAKINGPOWDER1)then
            native.setKeyboardFocus( nil )
            BakingPowder1TextField:removeEventListener("userInput", BakingPowder1Q)
            BakingPowder2TextField:removeEventListener("userInput", BakingPowder2Q)
            correctObject.isVisible = true
            if (soundOn == true) then
                correctSoundChannel = audio.play(correctSound)
            end
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            incorrectTextObject.isVisible = false
            BakingPowder1TextField.text = ""
            BakingPowder2TextField.text = ""
            BakingSodaV = true
            BakingPowder1.isVisible = false
            BakingPowder1TextField.isVisible = false
            BakingPowder2.isVisible = false
            BakingPowder2TextField.isVisible = false
            PlaceBakingPowder()
            BakingPowderImage:addEventListener("touch", DissapearBakingPowder)
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
            MilkV = true
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
            MilkV = true

        end
    end
end

local function PlaceMilk()
    MilkComplete = true
    MilkImage.x = math.random(100, display.contentWidth)
    MilkImage.y = math.random(160, display.contentHeight*330/512)
    while (MilkImage.x == pauseButton.x ) do
        MilkImage.x = math.random(100, display.contentWidth)
    end
    MilkImage.isVisible = true
end

local function MilkQ( event )
    -- ask the question
    if (event.phase=="began")then

        --clear text field 
       MilkTextField.text=""
    elseif(event.phase=="submitted")then
        userAnswerMilk = tostring(event.target.text)
        if (userAnswerMilk == ANSWERMILK)then
            native.setKeyboardFocus( nil )
            MilkTextField:removeEventListener("userInput", MilkQ)
            correctObject.isVisible = true
            if (soundOn == true ) then 
                correctSoundChannel = audio.play(correctSound)
            end
            timer.performWithDelay(2000,incorrectcorrectObjectinvisible)
            incorrectTextObject.isVisible = false
            MilkTextField.isVisible = false
            Milk.isVisible = false
            SaltV = true
            MilkV = false
            PlaceMilk()
            MilkImage:addEventListener("touch", DissapearMilk)
            
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
            MilkTextField.text = ""
            MilkV = false
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
    BakingPowder1TextField:addEventListener("userInput", BakingPowder1Q)
    BakingPowder2TextField:addEventListener("userInput", BakingPowder2Q)
    BakingSoda1TextField:addEventListener("userInput", BakingSoda1Q)
    BakingSoda2TextField:addEventListener("userInput", BakingSoda2Q)
    ButterTextField:addEventListener("userInput", ButterQ)
    Eggs1TextField:addEventListener("userInput", EggsQ)
    FlourTextField:addEventListener("userInput", FlourQ)
    MilkTextField:addEventListener("userInput", MilkQ)
    SaltTextField:addEventListener("userInput", SaltQ)
    SugarTextField:addEventListener("userInput", SugarQ)
end
   
local function create(  )
        -- Insert the background image
    bkg = display.newImageRect("Images/level2screen.png", display.contentWidth, display.contentHeight)
    bkg.x = display.contentCenterX
    bkg.y = display.contentCenterY
    bkg.width = display.contentWidth
    bkg.height = display.contentHeight
        -- Insert background image into the scene group in order to ONLY be associated with this scene
     
    -- insert first ingredient 


    BakingPowder1 = display.newText("Bakin ", 50 ,110, Arial, 35)
    BakingPowder1:setTextColor(0,0,0)  

    BakingPowder1TextField = native.newTextField(105 , 110 , 30 , 35)
    BakingPowder1TextField.inputType = "no-emoji"
    BakingPowder1TextField:setTextColor(0,0.3,0) 
    
    BakingPowder2 = display.newText("Powde", 180 , 110 , Arial , 35)
    BakingPowder2:setTextColor(0,0,0)  

    BakingPowder2TextField = native.newTextField(250, 110 , 30 , 35)
    BakingPowder2TextField:setTextColor(0,0.3,0)
    BakingPowder2TextField.inputType = "no-emoji"

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

    Milk = display.newText("Mil",900, 110, Arial, 35)
    Milk:setTextColor(0,0,0)

    MilkTextField = native.newTextField(940, 110, 30, 35)
    MilkTextField:setTextColor(0,0.3,0)
    MilkTextField.inputType = "no-emoji"

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

    BakingPowderImage = display.newImageRect("Images/bakingpowder.png", 100 , 100)
    BakingPowderImage.x = math.random(50, display.contentWidth)
    BakingPowderImage.y = math.random(160, display.contentHeight*330/512)
    BakingPowderImage.isVisible = false
    
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

    MilkImage = display.newImageRect("Images/milk.png", 150, 150)
    MilkImage.x = math.random(50, display.contentWidth)
    MilkImage.y = math.random(160, display.contentHeight*330/512)
    MilkImage.isVisible = false

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
    sceneGroup:insert( BakingPowder1 ) 
    sceneGroup:insert( BakingPowder1TextField ) 
    sceneGroup:insert( BakingPowder2 )
    sceneGroup:insert( BakingPowder2TextField ) 
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
    sceneGroup:insert( Milk )
    sceneGroup:insert( MilkTextField )  
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
    sceneGroup:insert(BakingPowderImage)
    sceneGroup:insert(BakingSodaImage)
    sceneGroup:insert(ButterImage)
    sceneGroup:insert(EggsImage)
    sceneGroup:insert(FlourImage)
    sceneGroup:insert(MilkImage)
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
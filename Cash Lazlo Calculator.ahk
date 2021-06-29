#NoEnv
#NoTrayIcon
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%
ListLines Off

#Include Assets.fy

; Compiler directives
;@Ahk2Exe-SetName Cash Lazlo Currency Calculator
;@Ahk2Exe-SetMainIcon app_icon.ico
;@Ahk2Exe-SetCopyright Baconfry & OhBirb @ 2021
;@Ahk2Exe-SetVersion 0.0.1

calculatorWidth := 300
, copperCoin := Assets . "\copper_coin.png"
, silverCoin := Assets . "\silver_coin.png"
, goldCoin := Assets . "\gold_coin.png"
, platinumCoin := Assets . "\platinum_coin.png"
, emeraldCoin := Assets . "\emerald_coin.png"
, inputWidth := (calculatorWidth - 56)

Gui, Calc:New,, Cash Lazlo Converter
Gui, Calc:Font, s13, Calibri
Gui, Calc:Add, Edit, y10 x10 w%inputWidth% h32 Limit15 Number gConvertCoins vCopperInput,
Gui, Calc:Add, Picture, x+6 w32 h32, % copperCoin
Gui, Calc:Add, Progress, x0 y+10 w%calculatorWidth% h1 BackgroundBlack

; Group One
Gui, Calc:Add, Text, x10 y+10 w%controlWidth%, % "Silver and copper coins:"
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % silverCoin
Gui, Calc:Add, Text, x+2 w%inputWidth% vGroupOneSilver, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % copperCoin
Gui, Calc:Add, Text, x+2 w%inputWidth% vGroupOneCopper, 0
Gui, Calc:Add, Progress, x0 y+10 w%calculatorWidth% h1 BackgroundBlack

; Group Two
Gui, Calc:Add, Text, x10 y+10 w%controlWidth%, % "Gold, silver and copper coins:"
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % goldCoin
Gui, Calc:Add, Text, x+2 w%inputWidth% vGroupTwoGold, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % silverCoin
Gui, Calc:Add, Text, x+2 w%inputWidth% vGroupTwoSilver, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % copperCoin
Gui, Calc:Add, Text, x+2 w%inputWidth% vGroupTwoCopper, 0
Gui, Calc:Add, Progress, x0 y+10 w%calculatorWidth% h1 BackgroundBlack

; Group Three
Gui, Calc:Add, Text, x10 y+10 w%controlWidth%, % "Platinum, gold, silver and copper coins:"
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % platinumCoin
Gui, Calc:Add, Text, x+2 w%inputWidth% vGroupThreePlatinum, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % goldCoin
Gui, Calc:Add, Text, x+2 w%inputWidth% vGroupThreeGold, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % silverCoin
Gui, Calc:Add, Text, x+2 w%inputWidth% vGroupThreeSilver, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % copperCoin
Gui, Calc:Add, Text, x+2 w%inputWidth% vGroupThreeCopper, 0
Gui, Calc:Add, Progress, x0 y+10 w%calculatorWidth% h1 BackgroundBlack

; Group Four
Gui, Calc:Add, Text, x10 y+10 w%controlWidth%, % "In terms of all coins:"
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % emeraldCoin
Gui, Calc:Add, Text, x+2 w%inputWidth% vGroupFourEmerald, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % platinumCoin
Gui, Calc:Add, Text, x+2 w%inputWidth% vGroupFourPlatinum, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % goldCoin
Gui, Calc:Add, Text, x+2 w%inputWidth% vGroupFourGold, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % silverCoin
Gui, Calc:Add, Text, x+2 w%inputWidth% vGroupFourSilver, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % copperCoin
Gui, Calc:Add, Text, x+2 w%inputWidth% vGroupFourCopper, 0
Gui, Calc:Add, Progress, x0 y+10 w%calculatorWidth% h1 BackgroundWhite vCalculatorHeightEnd

GuiControlGet, FinalControl, Pos, CalculatorHeightEnd
calculatorHeight := FinalControlY

Gui, Show, w%calculatorWidth% h%calculatorHeight%

; Delete temporary files
FileRemoveDir, %Assets%, 1
return

ConvertCoins:
    Gui, Calc:Submit, NoHide

    if(CopperInput = "") {
        GuiControl,  Calc:, GroupOneSilver, 0
        GuiControl,  Calc:, GroupOneCopper, 0
        
        GuiControl,  Calc:, GroupTwoGold, 0
        GuiControl,  Calc:, GroupTwoSilver, 0
        GuiControl,  Calc:, GroupTwoCopper, 0

        GuiControl,  Calc:, GroupThreePlatinum, 0
        GuiControl,  Calc:, GroupThreeGold, 0
        GuiControl,  Calc:, GroupThreeSilver, 0
        GuiControl,  Calc:, GroupThreeCopper, 0

        GuiControl,  Calc:, GroupFourEmerald, 0
        GuiControl,  Calc:, GroupFourPlatinum, 0
        GuiControl,  Calc:, GroupFourGold, 0
        GuiControl,  Calc:, GroupFourSilver, 0
        GuiControl,  Calc:, GroupFourCopper, 0
        return
    }

    ; Group one
    gOneSilver := Floor(CopperInput/5)
    , gOneCopper := Mod(CopperInput, 5)

    ; Group two
    gTwoGold := Floor(gOneSilver/5)
    gTwoSilver := Floor( (CopperInput/5) - (gTwoGold*5) )
    gTwoCopper := gOneCopper
    
    ; Group three
    gThreePlatinum := Floor(gTwoGold/5)
    gThreeGold := Floor( (gOneSilver/5) - (gThreePlatinum*5) )
    gThreeSilver := gTwoSilver
    gThreeCopper := gTwoCopper

    ; Group four
    gFourEmerald := Floor(gThreePlatinum/5)
    gFourPlatinum := Floor( (gTwoGold/5) - (gFourEmerald*5) )
    gFourGold := gThreeGold
    gFourSilver := gThreeSilver
    gFourCopper := gThreeCopper

    GuiControl,  Calc:, GroupOneSilver, % gOneSilver
    GuiControl,  Calc:, GroupOneCopper, % gOneCopper

    GuiControl,  Calc:, GroupTwoGold, % gTwoGold
    GuiControl,  Calc:, GroupTwoSilver, % gTwoSilver
    GuiControl,  Calc:, GroupTwoCopper, % gTwoCopper

    GuiControl,  Calc:, GroupThreePlatinum, % gThreePlatinum
    GuiControl,  Calc:, GroupThreeGold, % gThreeGold
    GuiControl,  Calc:, GroupThreeSilver, % gThreeSilver
    GuiControl,  Calc:, GroupThreeCopper, % gThreeCopper

    GuiControl,  Calc:, GroupFourEmerald, % gFourEmerald
    GuiControl,  Calc:, GroupFourPlatinum, % gFourPlatinum
    GuiControl,  Calc:, GroupFourGold, % gFourGold
    GuiControl,  Calc:, GroupFourSilver, % gFourSilver
    GuiControl,  Calc:, GroupFourCopper, % gFourCopper
return

CalcGuiClose:
ExitApp
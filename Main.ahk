#NoEnv
#NoTrayIcon
#SingleInstance, off
SetWorkingDir %A_ScriptDir%
ListLines Off

#Include Assets.fy
#Include OnExit.fy

; Compiler directives
;@Ahk2Exe-SetName Cash Lazlo Currency Calculator
;@Ahk2Exe-SetMainIcon app_icon.ico
;@Ahk2Exe-SetCopyright Baconfry & OhBirb @ 2021
;@Ahk2Exe-SetVersion 0.0.2

; This OnExit function will unload Mojangles once the app is closed
OnExit("OnAppExit")

calculatorWidth := 300
, copperCoin := Assets . "\copper_coin.png"
, silverCoin := Assets . "\silver_coin.png"
, goldCoin := Assets . "\gold_coin.png"
, platinumCoin := Assets . "\platinum_coin.png"
, emeraldCoin := Assets . "\emerald_coin.png"
, fontFile := Assets . "\Mojangles.ttf"
, inputWidth := (calculatorWidth - 20)
, controlWidth := (calculatorWidth - 10)
, conversionWidth := (calculatorWidth - 10 - 16 - 12) ; Coin start pos; coin width; dist to coin + padding

; Sideload Mojangles
DllCall( "Gdi32.dll\AddFontResourceEx"
        , "Str", fontFile
        , "UInt", (FR_PRIVATE := 0x10)
        , "Int", 0)

Gui, Calc:New,, Coinculator
Gui, Calc:Font, s19, Calibri ; Fallback font
Gui, Calc:Font, s17, Mojangles
Gui, Calc:Add, Edit, x10 y10  w%inputWidth% h32 Limit14 gConvertCoins vCopperInput Number,
Gui, Calc:Font, s12, Calibri ; Fallback font
Gui, Calc:Font, s12, Mojangles
Gui, Calc:Add, Text, x10 y+10, % "Input coin:"
Gui, Calc:Add, DropDownList, x+10 yp-2 vCoinChoice gCurrencyChange, Copper||Silver|Gold|Platinum|Emerald
Gui, Calc:Add, Progress, x0 y+10 w%calculatorWidth% h1 BackgroundBlack

; Group One
Gui, Calc:Add, Text, x10 y+10 w%controlWidth%, % "Silver and copper coins:"
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % silverCoin
Gui, Calc:Add, Text, x+2 w%conversionWidth% vGroupOneSilver, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % copperCoin
Gui, Calc:Add, Text, x+2 w%conversionWidth% vGroupOneCopper, 0
Gui, Calc:Add, Progress, x0 y+10 w%calculatorWidth% h1 BackgroundBlack

; Group Two
Gui, Calc:Add, Text, x10 y+10 w%controlWidth%, % "Gold, silver and copper coins:"
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % goldCoin
Gui, Calc:Add, Text, x+2 w%conversionWidth% vGroupTwoGold, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % silverCoin
Gui, Calc:Add, Text, x+2 w%conversionWidth% vGroupTwoSilver, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % copperCoin
Gui, Calc:Add, Text, x+2 w%conversionWidth% vGroupTwoCopper, 0
Gui, Calc:Add, Progress, x0 y+10 w%calculatorWidth% h1 BackgroundBlack

; Group Three
Gui, Calc:Add, Text, x10 y+10 w%controlWidth%, % "Platinum, gold, silver and copper coins:"
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % platinumCoin
Gui, Calc:Add, Text, x+2 w%conversionWidth% vGroupThreePlatinum, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % goldCoin
Gui, Calc:Add, Text, x+2 w%conversionWidth% vGroupThreeGold, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % silverCoin
Gui, Calc:Add, Text, x+2 w%conversionWidth% vGroupThreeSilver, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % copperCoin
Gui, Calc:Add, Text, x+2 w%conversionWidth% vGroupThreeCopper, 0
Gui, Calc:Add, Progress, x0 y+10 w%calculatorWidth% h1 BackgroundBlack

; Group Four
Gui, Calc:Add, Text, x10 y+10 w%controlWidth%, % "In terms of all coins:"
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % emeraldCoin
Gui, Calc:Add, Text, x+2 w%conversionWidth% vGroupFourEmerald, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % platinumCoin
Gui, Calc:Add, Text, x+2 w%conversionWidth% vGroupFourPlatinum, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % goldCoin
Gui, Calc:Add, Text, x+2 w%conversionWidth% vGroupFourGold, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % silverCoin
Gui, Calc:Add, Text, x+2 w%conversionWidth% vGroupFourSilver, 0
Gui, Calc:Add, Picture, x10 y+5 w16 h16, % copperCoin
Gui, Calc:Add, Text, x+2 w%conversionWidth% vGroupFourCopper, 0
Gui, Calc:Add, Progress, x0 y+10 w%calculatorWidth% h1 BackgroundWhite vCalculatorHeightEnd

GuiControlGet, FinalControl, Pos, CalculatorHeightEnd
calculatorHeight := FinalControlY

Gui, Show, w%calculatorWidth% h%calculatorHeight%

; Delete temporary files
FileRemoveDir, %Assets%, 1

return ; End of auto-execute section

ConvertCoins:
    Gui, Calc:Submit, NoHide

    switch CoinChoice
    {
        case "Silver":
            CopperInput *= 5
        case "Gold":
            CopperInput *= 25
        case "Platinum":
            CopperInput *= 125
        case "Emerald":
            CopperInput *= 625            
    }

    if (CopperInput = "") {
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
    gOneSilver := CopperInput//5
    gOneCopper := Mod(CopperInput, 5)

    ; Group two
    gTwoGold := gOneSilver//5
    gTwoSilver := Floor( (CopperInput/5) - (gTwoGold*5) )
    gTwoCopper := gOneCopper
    
    ; Group three
    gThreePlatinum := gTwoGold//5
    gThreeGold := Floor( (gOneSilver/5) - (gThreePlatinum*5) )
    gThreeSilver := gTwoSilver
    gThreeCopper := gTwoCopper

    ; Group four
    gFourEmerald := gThreePlatinum//5
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

CurrencyChange:
    Gui, Calc:Submit, NoHide
    switch CoinChoice
    {
        case "Silver":
            CopperInput *= 5
        case "Gold":
            CopperInput *= 25
        case "Platinum":
            CopperInput *= 125
        case "Emerald":
            CopperInput *= 625            
    }
    Gosub, ConvertCoins
return

CalcGuiClose:
ExitApp


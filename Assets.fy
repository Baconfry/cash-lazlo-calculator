Assets := A_Temp . "\CashLazlo"

; FileInstall won't work if the folder doesn't exist already
if !FileExist("%A_Temp%\CashLazlo")
    FileCreateDir, %Assets%

if !FileExist("%A_Temp%\CashLazlo\copper_coin.png")
    FileInstall, Assets\copper_coin.png, %Assets%\copper_coin.png, 1
if !FileExist("%A_Temp%\CashLazlo\silver_coin.png")
    FileInstall, Assets\silver_coin.png, %Assets%\silver_coin.png, 1
if !FileExist("%A_Temp%\CashLazlo\gold_coin.png")
    FileInstall, Assets\gold_coin.png, %Assets%\gold_coin.png, 1
if !FileExist("%A_Temp%\CashLazlo\platinum_coin.png")
    FileInstall, Assets\platinum_coin.png, %Assets%\platinum_coin.png, 1
if !FileExist("%A_Temp%\CashLazlo\emerald_coin.png")
    FileInstall, Assets\emerald_coin.png, %Assets%\emerald_coin.png, 1
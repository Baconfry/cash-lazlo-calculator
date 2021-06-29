OnAppExit()
{
    ; Unload Mojangles
    DllCall( "GDI32.DLL\RemoveFontResourceEx"
    , "Str" , fontFile
    , "UInt", (FR_PRIVATE := 0x10)
    , "Int", 0) 
}
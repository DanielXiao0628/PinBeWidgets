#SingleInstance force  ; Ensure only one instance of the script is running
CoordMode, Mouse, Screen  ; Set mouse coordinates to screen coordinates

; Define the bottom-right corner area
right_x := 1820  ; Right boundary x coordinate (1920 - 100)
bottom_y := 980   ; Bottom boundary y coordinate (1080 - 100)

; Function to minimize or restore all Chrome windows
ToggleChromeWindows() {
    ; Get list of all Chrome windows
    DetectHiddenWindows, On
    WinGet, chrome_windows, List, ahk_class Chrome_WidgetWin_1
    
    ; Toggle minimize or restore based on current state
    if (chrome_windows) {
        Loop, % chrome_windows {
            chrome_window := chrome_windows%A_Index%
            WinGet, chrome_state, MinMax, ahk_id %chrome_window%
            
            ; Minimize if not already minimized, restore if minimized
            if (chrome_state = -1) {
                WinRestore, ahk_id %chrome_window%
            } else {
                WinMinimize, ahk_id %chrome_window%
            }
        }
    }
}

; Left mouse button click event
~LButton::
  MouseGetPos, x, y  ; Get mouse click coordinates
  if (x > right_x AND y > bottom_y) {  ; Check if click is in the bottom-right corner
    ToggleChromeWindows()  ; Call function to minimize or restore Chrome windows
  }
return

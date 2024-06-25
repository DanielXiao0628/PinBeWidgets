#SingleInstance force  ; Ensure only one instance of the script is running
CoordMode, Mouse, Screen  ; Set mouse coordinates to screen coordinates

; Define the bottom-right corner area
right_x := 1820  ; Right boundary x coordinate (1920 - 100)
bottom_y := 980   ; Bottom boundary y coordinate (1080 - 100)

; State variables
chrome_minimized := false  ; Track if script minimized Chrome windows
last_minimized_window := ""  ; Store the last manually minimized window

; Function to minimize all Chrome windows
MinimizeChromeWindows() {
    global last_minimized_window
    DetectHiddenWindows, On
    WinGet, chrome_windows, List, ahk_class Chrome_WidgetWin_1
    
    if (chrome_windows) {
        Loop, % chrome_windows {
            chrome_window := chrome_windows%A_Index%
            WinGet, chrome_state, MinMax, ahk_id %chrome_window%
            
            if (chrome_state != -1) {  ; Minimize only if not already minimized
                WinMinimize, ahk_id %chrome_window%
                last_minimized_window := chrome_window
            }
        }
    }
}

; Function to restore all Chrome windows
RestoreChromeWindows() {
    DetectHiddenWindows, On
    WinGet, chrome_windows, List, ahk_class Chrome_WidgetWin_1
    
    if (chrome_windows) {
        Loop, % chrome_windows {
            chrome_window := chrome_windows%A_Index%
            WinGet, chrome_state, MinMax, ahk_id %chrome_window%
            
            if (chrome_state = -1) {  ; Restore only if minimized
                WinRestore, ahk_id %chrome_window%
            }
        }
    }
}

; Function to get the state of all Chrome windows
GetChromeWindowsState() {
    DetectHiddenWindows, On
    WinGet, chrome_windows, List, ahk_class Chrome_WidgetWin_1
    
    all_minimized := true
    all_maximized := true
    
    if (chrome_windows) {
        Loop, % chrome_windows {
            chrome_window := chrome_windows%A_Index%
            WinGet, chrome_state, MinMax, ahk_id %chrome_window%
            
            if (chrome_state != -1) {
                all_minimized := false
            }
            if (chrome_state != 1) {
                all_maximized := false
            }
        }
    }
    
    return {all_minimized: all_minimized, all_maximized: all_maximized}
}

; Left mouse button click event
~LButton::
  MouseGetPos, x, y  ; Get mouse click coordinates
  if (x > right_x AND y > bottom_y) {  ; Check if click is in the bottom-right corner
    state := GetChromeWindowsState()
    
    if (state.all_minimized) {
        if (chrome_minimized) {
            RestoreChromeWindows()  ; Restore all Chrome windows
            chrome_minimized := false  ; Update state
        } else if (last_minimized_window) {
            WinRestore, ahk_id %last_minimized_window%  ; Restore the last manually minimized window
            last_minimized_window := ""  ; Reset last minimized window
        }
    } else if (state.all_maximized) {
        MinimizeChromeWindows()  ; Minimize all Chrome windows
        chrome_minimized := true  ; Update state
    } else {
        MinimizeChromeWindows()  ; Minimize all Chrome windows
        chrome_minimized := true  ; Update state
    }
  }
return

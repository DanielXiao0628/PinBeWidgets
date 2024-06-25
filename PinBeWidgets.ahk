#SingleInstance force  ; Ensure only one instance of the script is running
CoordMode, Mouse, Screen  ; Set mouse coordinates to screen coordinates

; Define the bottom-right corner area
right_x := 1820  ; Right boundary x coordinate (1920 - 100)
bottom_y := 980   ; Bottom boundary y coordinate (1080 - 100)

; Chrome window state variable
chrome_minimized := false

; Left mouse button click event
~LButton::
  MouseGetPos, x, y  ; Get mouse click coordinates
  if (x > right_x AND y > bottom_y) {  ; Check if click is in the bottom-right corner
    if (chrome_minimized) {
      WinRestore, ahk_exe chrome.exe  ; Restore Chrome
      chrome_minimized := false  ; Update window state
    } else {
      WinMinimize, ahk_exe chrome.exe  ; Minimize Chrome
      chrome_minimized := true   ; Update window state
    }
  }
return

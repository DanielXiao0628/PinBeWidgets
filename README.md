# PinBeWidgets

## Purpose:
When using BeWidgets, clicking the Windows bottom-right corner to minimize all windows also minimizes the widgets. This script prevents that from happening.

## Prerequisites:
**AutoHotkey**: Download and install AutoHotkey from [https://www.autohotkey.com/](https://www.autohotkey.com/).

Screen Resolution: Adjust the right_x and bottom_y values in the script to match your screen resolution. Subtract 100 from each dimension to create a safe zone where the script won't interfere with normal minimization.

Taskbar Settings: In Windows settings, go to Taskbar -> Taskbar behaviors and uncheck the option "Select the far corner of the taskbar to show the desktop."

*（By default, only chrome.exe can be minimized. You can also add other programs in the format: program name + .exe）*

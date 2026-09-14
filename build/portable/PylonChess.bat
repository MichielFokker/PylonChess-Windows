@echo off
rem PylonChess launcher - runs the game with the bundled Python (no console).
set PYTHON=%~dp0python\pythonw.exe
if not exist "%PYTHON%" (
    echo Error: bundled Python not found. Expected at: "%PYTHON%"
    pause
    exit /b 1
)
start "" "%PYTHON%" -m pylonchess.main
exit /b 0
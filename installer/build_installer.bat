@echo off
rem PylonChess Windows build script.
rem Run this on Windows to compile the Inno Setup installer (setup.exe).
rem
rem Prerequisites (installed on the Windows machine):
rem   - Inno Setup 6  https://jrsoftware.org/isinfo.php  (iscc.exe on PATH or default install)
rem
rem The portable app bundle is already built in ..\build\portable
rem (bundled Python + pygame-ce + game source) - no Python needed on the
rem build machine.

setlocal
set ISCC=
for %%P in (iscc.exe) do set ISCC=%%~$PATH:P
if not defined ISCC (
    if exist "%ProgramFiles(x86)%\Inno Setup 6\ISCC.exe" (
        set ISCC=%ProgramFiles(x86)%\Inno Setup 6\ISCC.exe
    ) else if exist "%ProgramFiles%\Inno Setup 6\ISCC.exe" (
        set ISCC=%ProgramFiles%\Inno Setup 6\ISCC.exe
    )
)
if not defined ISCC (
    echo Error: ISCC.exe not found. Install Inno Setup 6 first.
    exit /b 1
)

echo === Building PylonChess-Setup-1.0.0-x64.exe ===
"%ISCC%" "PylonChess.iss"
if errorlevel 1 (
    echo Build FAILED.
    exit /b 1
)
echo.
echo Done. Installer written to ..\dist\PylonChess-Setup-1.0.0-x64.exe
endlocal
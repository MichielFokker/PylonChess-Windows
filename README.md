# PylonChess — Windows Build

Ready-to-run **portable** build of PylonChess for Windows x64, plus the tooling
to produce a proper Windows installer (`setup.exe`).

## What's included

```
PylonChess_Windows/
├── build/
│   └── portable/            # The app: bundled Python 3.14 + pygame-ce + game
│       ├── PylonChess.bat   # Double-click to play (no console window)
│       ├── PylonChess.vbs   # Silent launcher (hides the console entirely)
│       ├── pylonchess.ico   # App icon
│       └── python/          # Windows embeddable Python 3.14 x64
│           └── Lib/site-packages/   # pygame-ce 2.5.8 + pylonchess source
├── installer/
│   ├── PylonChess.iss       # Inno Setup 6 script
│   ├── build_installer.bat  # One-click installer build (run on Windows)
│   └── pylonchess.ico
├── dist/                    # Output: the produced installer / zip
└── README.md
```

## Run it on Windows (no installation)

Copy the `build/portable` folder to any Windows x64 machine and double-click
`PylonChess.bat`. Everything is self-contained - no Python required. Saves and
PGN exports go to `%USERPROFILE%\PylonChess\`.

To keep it neat, use `PylonChess.vbs` (no console flash) or add a shortcut to
`PylonChess.bat`.

## Build the installer (on Windows)

You need a Windows machine with **Inno Setup 6** installed:

```bat
installer\build_installer.bat
```

This produces `dist\PylonChess-Setup-1.0.0-x64.exe` - a standard setup.exe that
installs to `%LOCALAPPDATA%\Programs\PylonChess`, adds a Start Menu entry (and
optional desktop icon), and offers an uninstaller.

`PrivilegesRequired=lowest` means **no admin rights** are needed to install.

## Rebuilding the portable bundle (on Linux)

The bundle is already built, but to regenerate it from the source tree:

```bash
# python -m pip download pygame-ce==2.5.8 --platform win_amd64 \
#     --python-version 3.14 --implementation cp --only-binary=:all: --no-deps \
#     -d /tmp/pygame
# curl -L -o /tmp/python-3.14.7-embed-amd64.zip \
#     https://www.python.org/ftp/python/3.14.7/python-3.14.7-embed-amd64.zip
# unzip both into build/portable/python, then:
#   - unzip the pygame wheel into  python\Lib\site-packages
#   - copy the pylonchess/ source into python\Lib\site-packages\pylonchess
#   - make sure python314._pth lists "Lib\site-packages" and "import site"
```

## Notes

- Built with **pygame-ce 2.5.8** (cp314, win_amd64) and **CPython 3.14.7** embeddable.
- Game data, saves and PGN files are written under the user's home directory
  (`%USERPROFILE%\PylonChess\`), never inside the app folder, so the app works
  even when installed under `Program Files`.
- Sound is synthesised in memory - no audio files or codecs needed.
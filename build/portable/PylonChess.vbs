Set WshShell = CreateObject("WScript.Shell")
game = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) & "\python\pythonw.exe"
WshShell.Run """" & game & """ -m pylonchess.main", 0, False
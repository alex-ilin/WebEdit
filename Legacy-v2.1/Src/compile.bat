@setlocal
rem Return non-zero exit code if compilation fails.
xc =p WebEdit.prj
set err=%errorlevel%
xc =p WebEditU.prj
set /a err^|=%errorlevel%

@echo off
mkdir obj 2> NUL
move *.obj obj > NUL
move *.sym obj > NUL
move tmp.lnk obj > NUL
exit /b %err%

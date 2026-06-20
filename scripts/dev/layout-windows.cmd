@echo off
setlocal
cd /d "%~dp0\..\.."
echo ==^> Running repository layout checks
python scripts\audit-repo-layout.py || goto :fail
python scripts\check-workspace-paths.py || goto :fail
echo Layout checks passed.
if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b 0
:fail
echo Layout checks failed.
if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b 1

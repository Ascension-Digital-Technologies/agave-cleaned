@echo off
setlocal
cd /d "%~dp0\..\.."
echo ==^> Generating source manifest
python scripts\dev\source-manifest.py --write docs\source-manifest.json || goto :fail
echo Source manifest generated.
if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b 0
:fail
echo Source manifest generation failed.
if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b 1

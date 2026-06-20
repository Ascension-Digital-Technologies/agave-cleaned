@echo off
setlocal
cd /d "%~dp0\..\.."
echo ==^> Verifying source integrity
python scripts\dev\source-manifest.py --verify docs\source-manifest.json || goto :fail
echo Source integrity verified.
if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b 0
:fail
echo Source integrity verification failed.
if not "%AGAVE_NO_PAUSE%"=="1" pause
exit /b 1

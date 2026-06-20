@echo off
setlocal
cd /d "%~dp0\..\.."
echo ==^> Running GitHub-readiness checks
set AGAVE_NO_PAUSE=1
call scripts\dev\layout-windows.cmd || goto :fail
python scripts\dev\check-doc-links.py || goto :fail
python scripts\dev\check-generated-clean.py || goto :fail
cargo metadata --no-deps || goto :fail
echo Repository checks passed.
pause
exit /b 0
:fail
echo Repository checks failed.
pause
exit /b 1

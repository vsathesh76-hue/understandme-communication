@echo off
cd /d "%~dp0frontend"
if not exist "node_modules" (
  echo Installing frontend packages. This first run needs internet access...
  npm install
)
npm run dev -- --host 0.0.0.0
pause

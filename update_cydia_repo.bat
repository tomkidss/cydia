@echo off
chcp 65001 >nul
title UPDATE TOMKIDS CYDIA REPO

echo ================================
echo UPDATE TOMKIDS CYDIA REPO
echo ================================
echo.

set "LOG=%TEMP%\tomkids_cydia_update_log.txt"

echo Dang update repo...
echo Log: %LOG%
echo.

wsl bash /mnt/d/GitHub/cydia/build_repo_full_auto.sh > "%LOG%" 2>&1

type "%LOG%"

echo.
echo ================================
echo KET THUC
echo ================================
pause
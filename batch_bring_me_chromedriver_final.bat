@ECHO OFF

::Getting URL part
for /f "tokens=*" %%i in ('PowerShell -Command "(new-object net.webclient).DownloadString('https://chromedriver.storage.googleapis.com/LATEST_RELEASE')"') do set dversion=%%i

SET a=https://chromedriver.storage.googleapis.com/
SET b=%dversion%
SET c=/chromedriver_win32.zip
SET f=%a%%b%%c%
::echo URL with chromedriver: %f%

SET ORIGINAL_DIR=%CD% 
:: SET where=%CD% if u want driver next to script
SET where=C:\Users\****\Documents\****\
SET chromedriver=chromedriver.exe

::remove old chromedriver
cd %where%
del /Q %chromedriver%
cd %ORIGINAL_DIR%


::pobieranie 
MD folderX
(cd folderX/ && curl -O %f%)

::Unzip chromedriver
powershell Expand-Archive chromedriver_win32.zip  
CD chromedriver_win32

::Move chromedriver to specified location
MOVE chromedriver.exe %where%
CD ..
CD ..
::clear temporary directory
RD /S /Q folderX

::Print version of chrome and version of webdriver
set temp=vers.txt
dir /B/AD "C:\Program Files (x86)\Google\Chrome\Application\"|findstr /R /C:"^[0-9].*\..*[0-9]$" > %temp%
set /p verx=<%temp%
del /Q %temp%

echo:
echo:
echo:
echo Installed chrome version: %verx%
echo Selenium updated driver : %b%

PAUSE
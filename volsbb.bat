rem Ensure That Wifi is enabled before runnning this
@echo off
set SSID="VIT2.4G"
set CURRENT_DIR=%cd%
set PASSWORD_FILE="%CURRENT_DIR%\Password.txt"
set USERNAME_FILE="%CURRENT_DIR%\Username.txt"
set VOLSBB_USERNAME
set VOLSBB_PASSWORD

netsh wlan show interfaces | find %SSID%
if not errorlevel 1 (
	CALL :login
) else (
	@echo on
	echo "Connecting To %SSID%"
	@echo off
	netsh wlan connect name=%SSID%
	if errorlevel 1 (
		@echo on
		echo "Can't Found %SSID%"
		pause
		goto:eof
	)
	CALL :login
)
pause
goto:eof

:login
@echo off
CALL :read-username
CALL :read-password
IF NOT DEFINED VOLSBB_USERNAME (
	CALL :username-prompt
	CALL :password-prompt
)
IF NOT DEFINED VOLSBB_PASSWORD (
	CALL :username-prompt
	CALL :password-prompt
)
@echo off
powershell -Command "Invoke-RestMethod -Method Post http://phc.prontonetworks.com/cgi-bin/authlogin?URI=http://www.msftncsi.com/redirect -Body 'userId=%VOLSBB_USERNAME%&password=%VOLSBB_PASSWORD%&serviceName=ProntoAuthentication&Submit22=Login'"
goto:eof


:username-prompt
@echo off
powershell -Command "& {Read-Host "Enter Username" | Out-File %USERNAME_FILE%}"
CALL :read-username
goto:eof

:read-username
@echo off
IF EXIST %USERNAME_FILE% (
	FOR /F "usebackq delims=" %%v IN (
		`powershell -command "& {$user = Get-Content %USERNAME_FILE% ; echo $user}"`
		) DO set "VOLSBB_USERNAME=%%v"
)
goto:eof


:password-prompt
@echo off
powershell -Command "& {Read-Host "Enter Password" -AsSecureString |  ConvertFrom-SecureString | Out-File %PASSWORD_FILE%}"
CALL :read-password
goto:eof

:read-password
@echo off
IF EXIST %PASSWORD_FILE% (
	FOR /F "usebackq delims=" %%v IN (
		`powershell -command "& {$pass = Get-Content %PASSWORD_FILE% | ConvertTo-SecureString; $stringValue = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass));echo $stringValue}"`
		) DO set "VOLSBB_PASSWORD=%%v"
)
goto:eof
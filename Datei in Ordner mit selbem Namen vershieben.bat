@echo off
rem Batch: Datei in einen Ordner mit dem gleichen Namen verschieben
rem Nutzung: Ziehe eine Datei auf diese .bat oder rufe sie mit dem Dateipfad als Parameter auf:
rem    test.bat "C:\Pfad\zur\Datei.txt"

setlocal

if "%~1"=="" (
    echo Ziehe eine Datei auf diese Batch-Datei oder gib den Pfad ein.
    set /p "file=Pfad zur Datei: "
) else (
    set "file=%~1"
)

if not exist "%file%" (
    echo Datei "%file%" nicht gefunden.
    pause
    exit /b 1
)

for %%F in ("%file%") do (
    set "full=%%~fF"
    set "name=%%~nF"
    set "dir=%%~dpF"
)

set "target=%dir%%name%"

if exist "%target%\" (
    echo Zielordner "%target%" existiert bereits.
) else (
    md "%target%" 2>nul
    if errorlevel 1 (
        echo Ordner "%target%" konnte nicht erstellt werden.
        pause
        exit /b 1
    )
)

move "%full%" "%target%\" >nul
if errorlevel 1 (
    echo Verschieben fehlgeschlagen.
    pause
    exit /b 1
) else (
    echo Datei erfolgreich nach "%target%\" verschoben.
)

endlocal

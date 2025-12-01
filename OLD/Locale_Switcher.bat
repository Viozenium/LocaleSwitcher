@echo off
set ScriptPath=C:\Users\%USERNAME%\Path_to_File\Locale_Switcher.ps1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%ScriptPath%""' -Verb RunAs"


:: -------------------------

:: Italiano:

:: Define il percorso completo dello script PowerShell da eseguire.
:: %USERNAME% inserisce automaticamente il nome utente di Windows.

:: English:

:: Defines the full path of the PowerShell script to run.
:: %USERNAME% automatically inserts the current Windows username.

:: -------------------------

:: Italiano:

:: powershell -NoProfile:
::     Avvia PowerShell senza caricare il profilo dell’utente.
:: -ExecutionPolicy Bypass:
::     Permette l'esecuzione dello script anche se la politica la bloccherebbe.
:: -Command "Start-Process ...":
::     Esegue un comando che lancia un nuovo PowerShell elevato (RunAs).

:: Start-Process powershell:
::     Avvia un nuovo processo PowerShell separato.
:: -ArgumentList:
::     Argomenti da passare al nuovo PowerShell, tra cui:
::        -NoProfile
::        -ExecutionPolicy Bypass
::        -File "%ScriptPath%"  → lo script da eseguire
:: -Verb RunAs:
::     Richiede l'esecuzione come amministratore.

:: English:

:: powershell -NoProfile:
::     Launches PowerShell without loading the user profile.
:: -ExecutionPolicy Bypass:
::     Allows script execution even if normally blocked.
:: -Command "Start-Process ...":
::     Runs a command that starts a new elevated (RunAs) PowerShell instance.

:: Start-Process powershell:
::     Starts a separate PowerShell process.
:: -ArgumentList:
::     Arguments passed to the new PowerShell instance, including:
::        -NoProfile
::        -ExecutionPolicy Bypass
::        -File "%ScriptPath%"  → the script to execute
:: -Verb RunAs:
::     Requests elevated permissions (Run as Administrator).
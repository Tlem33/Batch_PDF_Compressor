:: https://github.com/Tlem33/Batch_PDF_Compressor
:: Batch_PDF_Compressor.cmd - Version 1.0 du 12/12/2020
::
:: ANSI -> OEM : ้ =  | ่ =  | เ = … | โ =  | ๊ =  | ๎ =  | ๔ = “ | ๛ = – | ็ = 
::


@@Echo Off
Cls


:: D้claration des variables
SETLOCAL ENABLEDELAYEDEXPANSION
Set Version=1.0
Set Count=0
Set GsWinExe=gswin64c.exe
Set GsWinDll=gsdll64.dll
Set Mode=x64


:: Utilisation de la version 32 bits sur syst่me 32 bits
If Not Exist "%programfiles% (x86)" (
	Set GsWinExe=gswin32c.exe
	Set GsWinDll=gsdll32.dll
	Set Mode=x86
)


:: Si pas de Drag&Drop
If "%~1"=="" (
	Call :ErrorMsg
	Echo Aucun fichiers … traiter ...
	Echo Vous devez faire glisser un ou plusieurs fichiers/dossiers sur ce batch !
	Echo.
	Echo.
	Echo Appuyez sur une touche pour quitter
	Pause>Nul
	Exit
)


:: Mise en tableau de la liste des fichiers
For %%I In (%*) Do (
    Echo.%%~aI | Find "d" >Nul
    If ERRORLEVEL 1 (
        REM traitement des fichiers
		Echo."%%~fI" | FIND ".pdf" >Nul
		If Errorlevel 0 (
			Set /A Count+=1
			Set AFiles[!count!]="%%~fI"
		)
    ) Else (
        REM traitement des dossiers
		For /F "Tokens=*" %%a in ('Dir "%%~I\*.pdf" /B /S') Do (
			Set /A Count+=1
			Set AFiles[!count!]="%%a"
		)
    )
)


:: Si aucun fichier PDF => Erreur
If %count%==0 (
	Call :ErrorMsg
	Echo Il n'y a aucun fichiers PDF … traiter ...
	Echo.
	Echo.
	Echo Appuyez sur une touche pour quitter
	Pause>Nul
	Exit
)


:: V้rifie si gswin32c.exe ou gswin64c.exe est pr้sent.
If Not Exist "%~DP0bin\%GsWinExe%" (
	Call :GsWin_Error
)

:: V้rifie si gsdll32.dll ou gsdll64.dll est pr้sent.
If Not Exist "%~DP0bin\%GsWinDll%" (
	Call :GsWin_Error
)


:Menu
Cls
Color 0F
Echo                         ษออออออออออออออออออออออออออออออป
Echo                         บ                              บ
Echo                         บ      PDF Compressor v%version%     บ
Echo                         บ           Mode %Mode%           บ
Echo                         บ                              บ
Echo                         ศออออออออออออออออออออออออออออออผ
Echo.
Echo.
:: Singulier ou pluriel selon le nombre de fichier.
If %Count% LEQ 1 (
	Echo   Fichier PDF … traiter : %count% 
) Else (
	Echo   Fichiers PDF … traiter : %count% 
)
Echo.
Echo.
Echo   Quelle type de compression dsirez-vous raliser :
Echo.
Echo          1 - "screen"   - Compression forte, qualit faible
Echo.
Echo          2 - "ebook"    - Compression forte, qualit moyenne
Echo.
Echo          3 - "default"  - Compression bonne, qualit bonne
Echo.
Echo          4 - "printer"  - Compression moyenne, qualit bonne
Echo.
Echo          5 - "prepress" - Compression faible, qualit haute
Echo.
Echo          6 - Quitter
Echo.
Echo.
Echo.
Set /P CompMode=Entrez votre choix : 1 , 2, 3, 4, 5 ou 6 (Choix 2 par dfaut) :
If /I "%CompMode%" EQU "" Set CompMode=ebook &Goto :Start
If /I "%CompMode%" EQU "1" Set CompMode=screen &Goto :Start
If /I "%CompMode%" EQU "2" Set CompMode=ebook &Goto :Start
If /I "%CompMode%" EQU "3" Set CompMode=default &Goto :Start
If /I "%CompMode%" EQU "4" Set CompMode=printer &Goto :Start
If /I "%CompMode%" EQU "5" Set CompMode=prepress &Goto :Start
If /I "%CompMode%" EQU "6" Exit
Goto :Menu


:Start
Cls


:: V้rifie si on a le droit d'้criture dans le dossier des pdf
:CheckWrite
:: R้cup่re le dossier du premier fichier.
For /F "Delims=" %%a In ('Echo %AFiles[1]%') Do Set FileDir=%%~dpa

:: V้rifie l'acc้s en ้criture
MKdir "%FileDir%~TestDir">Nul 2>Nul
If Not Exist "%FileDir%~TestDir" (
	Call :ErrorMsg
	Echo Vous n'avez pas accs en criture au dossier "%FileDir%"
	Echo.
	Echo Dplacez ou copiez les PDF dans un dossier ou vous avez
	Echo les droits d'criture et relancez l'opration.
	Echo.
	Echo.
	Echo Appuyez sur une touche pour quitter
	Pause>Nul
	Exit
) Else (
	RD "%FileDir%\~TestDir"
)


:Choice
Cls
Set /P Keep=Souhaitez-vous conserver les fichiers originaux ? (O ou N) (Oui par dfaut) :
If /I "%Keep%" EQU "" Set Keep=1 & Goto :Processing
If /I "%Keep%" EQU "O" Set Keep=1 & Goto :Processing
If /I "%Keep%" EQU "N" Set Keep=0 & Goto :Processing
Goto :Choice


:Processing
Cls
ECho Traitement des fichiers en mode "%CompMode%"

:: Boucle de lecture du tableau et appel เ la fonction de compression
For /L %%I In (1,1,%Count%) Do (
	call :Compress %%AFiles[%%I]%%
)

:: Affichage selon le nombre de fichiers trait้s.
Echo.
If %Count% LEQ 1 (
	Echo %Count% fichier trait.
) Else (
	Echo %Count% fichiers traits.
)
Echo Appuyez sur une touche pour quitter.
Pause>Nul
Exit


:Compress
Echo.
Call :GetFileSize FileSize %1
Echo Traitement du fichier  : %1  (%FileSize%)
Echo Veuillez patienter ...
:: Param้trage du nom du fichier de sortie.
If %Keep%==1 (
	Set OutputFile=%~n1_%CompMode%.pdf
) Else (
	Set OutputFile=%~n1.pdf
)

:: Compression avec GhostScript
:: PDFSETTINGS : screen / ebook / printer / prepress / default
"%~dp0bin\%GsWinExe%" -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/%CompMode% -dNOPAUSE -dBATCH -sOutputFile="%temp%\%OutputFile%" "%~1">Nul

:: D้placement du fichier de sortie vers sa destination
Move /Y "%temp%\%OutputFile%" "%~DP1\">Nul
For /F "Delims=" %%s In ('Dir "%~DP1\%OutputFile%"') Do Set FileSize=%%~zs

Call :GetFileSize FileSize "%~DP1\%OutputFile%"
Echo Fichier de sortie cr : "%~DP1\%OutputFile%"  (%FileSize%)
Exit /b


:: Retourne la taille du fichier dans la variable Size
:: Appeler la fonction comme ceci : Call :GetFileSize Size %fichier%
:GetFileSize <Size> <Fichier>
SET DONE=0
SET Bytes=%~z2
SET KB=%Bytes:~0,-3%
SET MB=%Bytes:~0,-6%
SET GB=%Bytes:~0,-9%
SET TB=%Bytes:~0,-12%

IF "%KB%" EQU "" SET DONE=B
IF %DONE% EQU B set "%~1=%Bytes% Octets" & Exit /b

IF "%MB%" EQU "" SET DONE=K
IF %DONE% EQU K SET /a KB=(%BYTES%/1024)+1 & set "%~1=%KB% Ko" & Exit /b

IF "%GB%" EQU "" SET DONE=M
IF %DONE% EQU M SET /a MB=(%BYTES%/1048576)+1 & set "%~1=%MB% Mo" & Exit /b

IF "%TB%" EQU "" SET DONE=M
IF %DONE% EQU M SET /a MB=%KB%/1049 & set "%~1=%MB% Mo (environ)" & Exit /b

SET DONE=G
IF %DONE% EQU G SET /a GB=%MB%/1074 & set "%~1=%GB% Go (environ)" & Exit /b
Exit /b


:GsWin_Error
Call :ErrorMsg
Echo Erreur, le programme %GsWinExe% et/ou %GsWinDll% n'a pas t trouv ...
Echo.
Echo Tlchargez Ghostscript depuis ce site : https://www.ghostscript.com/download
Echo Puis dcompressez et placez %GsWinExe% ainsi que %GsWinDll% dans le dossier \bin.
Echo.
Echo.
Echo Appuyez sur une touche pour quitter.
Pause>Nul
Exit
Exit /b


:ErrorMsg
Color 0C
Echo.
Echo                          ษออออออออออออออออออออออออออป
Echo                          บ                          บ
Echo                          บ          ERREUR          บ
Echo                          บ                          บ
Echo                          ศออออออออออออออออออออออออออผ
Echo.
Echo.
Exit /b

@echo off
setlocal enabledelayedexpansion
color 0A
title Utilitario de Reparo do Sistema Windows

:: Verificar se está em modo Administrador
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo ===================================================
    echo  ESTE SCRIPT PRECISA SER EXECUTADO COMO ADMINISTRADOR
    echo  Clique com o botao direito e selecione:
    echo  "Executar como administrador"
    echo ===================================================
    pause
    exit /b
)

echo ===================================================
echo   UTILITARIO DE REPARO DO SISTEMA WINDOWS
echo   Desenvolvido por: Lucas Campos
echo   GitHub: https://github.com/lucascampos42
echo ===================================================
echo.
echo ===================================================
echo        UTILITARIO DE REPARO DO SISTEMA WINDOWS
echo ===================================================
echo.
echo  Este utilitario permite:
echo.
echo  1. Verificar e reparar arquivos do sistema (DISM + SFC)
echo    - Corrige problemas com arquivos corrompidos do Windows
echo    - Usa comandos: DISM /CheckHealth, /ScanHealth, /RestoreHealth, SFC /scannow
echo.
echo  2. Verificar e corrigir erros no disco (CHKDSK)
echo    - Verifica setores danificados e arquivos corrompidos
echo    - Pode exigir reinicializacao
echo.
echo ===================================================
echo.

:MENU
echo Escolha uma opcao:
echo [1] Verificar e reparar sistema (DISM + SFC)
echo [2] Verificar disco (CHKDSK)
echo [0] Sair
set /p opcao=Digite sua escolha: 

if "%opcao%"=="1" goto reparo
if "%opcao%"=="2" goto chkdsk
if "%opcao%"=="0" exit
goto MENU

:: =============================
::   OPCAO 1 - REPARO SISTEMA
:: =============================
:reparo
cls
echo ======================================
echo INICIANDO VERIFICACAO E REPARO DO SISTEMA
echo ======================================
echo.

:: DISM /CheckHealth
echo [1/4] Verificando estado com DISM /CheckHealth...
DISM /Online /Cleanup-Image /CheckHealth
echo.
timeout /t 2 >nul

:: DISM /ScanHealth
echo [2/4] Escaneando integridade da imagem com DISM /ScanHealth...
DISM /Online /Cleanup-Image /ScanHealth
echo.
timeout /t 2 >nul

:: DISM /RestoreHealth
echo [3/4] Restaurando imagem com DISM /RestoreHealth...
DISM /Online /Cleanup-Image /RestoreHealth
echo.
timeout /t 2 >nul

:: SFC
echo [4/4] Verificando arquivos do sistema com SFC /scannow...
sfc /scannow
echo.
echo ======================================
echo REPARO FINALIZADO.
echo ======================================
pause
goto fim

:: =============================
::   OPCAO 2 - CHKDSK
:: =============================
:chkdsk
cls
echo ======================================
echo VERIFICACAO DO DISCO RIGIDO (CHKDSK)
echo ======================================
echo.
echo Este processo vai verificar e tentar corrigir
echo erros na unidade C: (como setores danificados).
echo.
echo Ele pode levar bastante tempo e vai pedir para
echo ser executado na proxima reinicializacao.
echo.

pause
chkdsk C: /f /r
echo.
echo Se solicitado, digite S para agendar na reinicializacao.
pause
goto fim

:: =============================
::   FIM
:: =============================
:fim
exit

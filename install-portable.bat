@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo.
echo ========================================
echo    GIT TOOLS - INSTALADOR PORTATIL
echo ========================================
echo.

:: Verificar se o Git está instalado
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ ERRO: Git não está instalado!
    echo Por favor, instale o Git primeiro: https://git-scm.com/
    pause
    exit /b 1
)

:: Verificar se o arquivo ZIP existe
if not exist "git-tools-portable.zip" (
    echo ❌ ERRO: Arquivo 'git-tools-portable.zip' não encontrado!
    echo Certifique-se de que está na mesma pasta do instalador.
    pause
    exit /b 1
)

:: Criar pasta de instalação
set "INSTALL_DIR=%USERPROFILE%\.git-tools"
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

echo 📁 Instalando em: %INSTALL_DIR%
echo.

:: Extrair arquivos
echo 🔄 Extraindo arquivos...
powershell -command "Expand-Archive -Path 'git-tools-portable.zip' -DestinationPath '%INSTALL_DIR%' -Force"

if errorlevel 1 (
    echo ❌ ERRO: Falha ao extrair arquivos!
    pause
    exit /b 1
)

:: Tornar scripts executáveis (se estiver no WSL)
if exist "%USERPROFILE%\AppData\Local\Microsoft\WindowsApps\wsl.exe" (
    echo 🔧 Configurando permissões no WSL...
    wsl chmod +x "%INSTALL_DIR%/*.sh" 2>nul
)

:: Criar arquivo de aliases para CMD
set "ALIASES_FILE=%USERPROFILE%\.git-tools-aliases.cmd"
echo @echo off > "%ALIASES_FILE%"
echo REM Aliases para Git Tools >> "%ALIASES_FILE%"
echo. >> "%ALIASES_FILE%"
echo set "GIT_TOOLS_DIR=%INSTALL_DIR%" >> "%ALIASES_FILE%"
echo. >> "%ALIASES_FILE%"
echo REM Aliases principais >> "%ALIASES_FILE%"
echo doskey githelp="%INSTALL_DIR%\git-help.sh" $* >> "%ALIASES_FILE%"
echo doskey gitmenu="%INSTALL_DIR%\git-menu.sh" $* >> "%ALIASES_FILE%"
echo doskey gitinit="%INSTALL_DIR%\git-init.sh" $* >> "%ALIASES_FILE%"
echo doskey gitcommit="%INSTALL_DIR%\git-commit.sh" $* >> "%ALIASES_FILE%"
echo doskey gitpush="%INSTALL_DIR%\git-push.sh" $* >> "%ALIASES_FILE%"
echo doskey gitpull="%INSTALL_DIR%\git-pull.sh" $* >> "%ALIASES_FILE%"
echo doskey gitsync="%INSTALL_DIR%\git-sync.sh" $* >> "%ALIASES_FILE%"
echo doskey gitbranch="%INSTALL_DIR%\git-branch.sh" $* >> "%ALIASES_FILE%"
echo doskey gitstash="%INSTALL_DIR%\git-stash.sh" $* >> "%ALIASES_FILE%"
echo doskey gitmerge="%INSTALL_DIR%\git-merge.sh" $* >> "%ALIASES_FILE%"
echo doskey gittag="%INSTALL_DIR%\git-tag.sh" $* >> "%ALIASES_FILE%"
echo doskey gitlog="%INSTALL_DIR%\git-log.sh" $* >> "%ALIASES_FILE%"
echo. >> "%ALIASES_FILE%"
echo REM Aliases curtos >> "%ALIASES_FILE%"
echo doskey help=githelp $* >> "%ALIASES_FILE%"
echo doskey ghelp=githelp $* >> "%ALIASES_FILE%"
echo doskey menu=gitmenu $* >> "%ALIASES_FILE%"
echo doskey init=gitinit $* >> "%ALIASES_FILE%"
echo doskey commit=gitcommit $* >> "%ALIASES_FILE%"
echo doskey push=gitpush $* >> "%ALIASES_FILE%"
echo doskey pull=gitpull $* >> "%ALIASES_FILE%"
echo doskey sync=gitsync $* >> "%ALIASES_FILE%"
echo doskey branch=gitbranch $* >> "%ALIASES_FILE%"
echo doskey stash=gitstash $* >> "%ALIASES_FILE%"
echo doskey merge=gitmerge $* >> "%ALIASES_FILE%"
echo doskey tag=gittag $* >> "%ALIASES_FILE%"
echo doskey log=gitlog $* >> "%ALIASES_FILE%"

:: Configurar PowerShell
set "PS_PROFILE=%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
if not exist "%PS_PROFILE%" (
    echo # PowerShell Profile > "%PS_PROFILE%"
)

:: Adicionar configuração ao PowerShell
echo. >> "%PS_PROFILE%"
echo # Git Tools Configuration >> "%PS_PROFILE%"
echo $env:GIT_TOOLS_DIR = "%INSTALL_DIR%" >> "%PS_PROFILE%"
echo. >> "%PS_PROFILE%"
echo # Git Tools Aliases >> "%PS_PROFILE%"
echo Set-Alias -Name githelp -Value "$INSTALL_DIR\git-help.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name gitmenu -Value "$INSTALL_DIR\git-menu.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name gitinit -Value "$INSTALL_DIR\git-init.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name gitcommit -Value "$INSTALL_DIR\git-commit.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name gitpush -Value "$INSTALL_DIR\git-push.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name gitpull -Value "$INSTALL_DIR\git-pull.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name gitsync -Value "$INSTALL_DIR\git-sync.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name gitbranch -Value "$INSTALL_DIR\git-branch.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name gitstash -Value "$INSTALL_DIR\git-stash.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name gitmerge -Value "$INSTALL_DIR\git-merge.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name gittag -Value "$INSTALL_DIR\git-tag.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name gitlog -Value "$INSTALL_DIR\git-log.sh" >> "%PS_PROFILE%"
echo. >> "%PS_PROFILE%"
echo # Short Aliases >> "%PS_PROFILE%"
echo Set-Alias -Name help -Value "$INSTALL_DIR\git-help.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name ghelp -Value "$INSTALL_DIR\git-help.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name menu -Value "$INSTALL_DIR\git-menu.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name init -Value "$INSTALL_DIR\git-init.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name commit -Value "$INSTALL_DIR\git-commit.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name push -Value "$INSTALL_DIR\git-push.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name pull -Value "$INSTALL_DIR\git-pull.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name sync -Value "$INSTALL_DIR\git-sync.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name branch -Value "$INSTALL_DIR\git-branch.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name stash -Value "$INSTALL_DIR\git-stash.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name merge -Value "$INSTALL_DIR\git-merge.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name tag -Value "$INSTALL_DIR\git-tag.sh" >> "%PS_PROFILE%"
echo Set-Alias -Name log -Value "$INSTALL_DIR\git-log.sh" >> "%PS_PROFILE%"

echo ✅ Instalação concluída com sucesso!
echo.
echo 🎯 Para usar os comandos:
echo.
echo 📋 CMD: Execute "%ALIASES_FILE%"
echo 🔧 PowerShell: Reinicie o PowerShell
echo.
echo 💡 Comandos disponíveis:
echo    githelp - Ver todos os comandos
echo    gitmenu - Menu principal
echo    gitinit - Inicializar repositório
echo    gitcommit - Fazer commit
echo    gitpush - Enviar alterações
echo    gitpull - Baixar alterações
echo    gitsync - Sincronizar
echo.
echo 🗂️  Arquivos instalados em: %INSTALL_DIR%
echo.
pause

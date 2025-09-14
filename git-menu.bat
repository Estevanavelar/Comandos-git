@echo off
title Git Menu - Automacao Git

REM Verifica se há uma instalação global do Git Tools
set "GLOBAL_INSTALL_DIR=%USERPROFILE%\.git-tools"
if exist "%GLOBAL_INSTALL_DIR%\git-menu.sh" (
    echo ✅ Usando menu global do Git Tools
    "C:\Program Files\Git\bin\bash.exe" "%GLOBAL_INSTALL_DIR%\git-menu.sh"
) else (
    echo ⚠️  Instalação global não encontrada, usando versão local.
    echo 💡 Para instalar globalmente, execute: install-git-tools.ps1
    if exist "git-menu.sh" (
        "C:\Program Files\Git\bin\bash.exe" "git-menu.sh"
    ) else (
        echo ❌ Script git-menu.sh não encontrado!
        echo Execute este arquivo na pasta dos Git Tools.
    )
)
pause

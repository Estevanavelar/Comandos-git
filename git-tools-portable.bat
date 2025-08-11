@echo off
REM Git Tools Portátil para Windows - Funciona em qualquer pasta
REM Uso: git-tools-portable.bat [comando] [opções]

setlocal enabledelayedexpansion

REM Diretório onde está este arquivo
set "SCRIPT_DIR=%~dp0"

REM Verifica se Git está instalado
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Erro: Git não está instalado ou não está no PATH!
    echo Instale o Git em: https://git-scm.com/
    pause
    exit /b 1
)

REM Função para mostrar banner
:show_banner
echo.
echo ╔════════════════════════════════════════╗
echo ║        GIT TOOLS PORTÁTIL             ║
echo ║         Windows CMD                    ║
echo ╚════════════════════════════════════════╝
echo.
goto :eof

REM Função para mostrar ajuda
:show_help
call :show_banner
echo 📋 COMANDOS DISPONÍVEIS:
echo.
echo 🎯 OPERAÇÕES BÁSICAS:
echo   menu     - Menu interativo principal
echo   commit   - Commit rápido
echo   comitar  - Commit alternativo
echo   pull     - Atualizar do remoto
echo   push     - Enviar para remoto
echo   sync     - Sincronização completa
echo.
echo 🌿 GERENCIAMENTO:
echo   branch   - Gerenciar branches
echo   stash    - Gerenciar stashes
echo   merge    - Gerenciar merges
echo   tag      - Gerenciar tags
echo   log      - Ver histórico/logs
echo.
echo 💡 EXEMPLOS DE USO:
echo   git-tools-portable.bat menu
echo   git-tools-portable.bat commit "feat: nova funcionalidade"
echo   git-tools-portable.bat sync "atualizações do dia"
echo   git-tools-portable.bat branch
echo.
echo 💡 DICA: Execute sem parâmetros para ver este menu!
goto :eof

REM Função para verificar se está em repositório Git
:check_git_repo
git rev-parse --git-dir >nul 2>&1
if errorlevel 1 (
    echo ❌ Erro: Não está em um repositório Git!
    echo.
    echo Opções:
    echo 1) Inicializar novo repositório aqui
    echo 2) Clonar repositório existente
    echo 3) Sair
    echo.
    set /p "init_choice=Escolha uma opção: "
    
    if "!init_choice!"=="1" (
        git init
        echo ✅ Repositório Git inicializado!
        echo.
        pause
    ) else if "!init_choice!"=="2" (
        echo.
        set /p "repo_url=URL do repositório: "
        if not "!repo_url!"=="" (
            git clone !repo_url!
            echo ✅ Repositório clonado!
            echo Entre no diretório clonado e execute o script novamente.
        ) else (
            echo ❌ URL vazia!
        )
        exit /b 0
    ) else if "!init_choice!"=="3" (
        exit /b 0
    )
)
goto :eof

REM Função para executar script
:run_script
set "script_name=%~1"
set "script_path=!SCRIPT_DIR!%script_name%.sh"

if exist "!script_path!" (
    REM Passa todos os argumentos para o script
    shift
    "C:\Program Files\Git\bin\bash.exe" "!script_path!" %*
) else (
    echo ❌ Script %script_name%.sh não encontrado!
    echo Certifique-se de que todos os scripts estão no diretório: !SCRIPT_DIR!
    pause
    exit /b 1
)
goto :eof

REM Função para menu interativo
:show_menu
:menu_loop
cls
call :show_banner
call :check_git_repo

echo.
echo 📊 Status do Repositório:
for /f "tokens=*" %%i in ('git rev-parse --show-toplevel 2^>nul') do set "repo_name=%%~nxi"
echo 📁 Diretório: !repo_name!

for /f "tokens=*" %%i in ('git branch --show-current 2^>nul') do set "current_branch=%%i"
echo 🌿 Branch atual: !current_branch!

REM Verifica se há mudanças
git status --porcelain >nul 2>&1
if errorlevel 1 (
    echo 📝 Status: Mudanças pendentes
) else (
    echo 📝 Status: Limpo
)

echo.
echo ═══════════════════════════════════════
echo.
echo 📋 OPERAÇÕES BÁSICAS:
echo   1) 💾 Commit rápido
echo   2) 📥 Pull (atualizar do remoto)
echo   3) 📤 Push (enviar para remoto)
echo   4) 🔄 Sync (sincronização completa)
echo.
echo 🌿 GERENCIAMENTO:
echo   5) 📑 Gerenciar branches
echo   6) 📊 Ver status detalhado
echo   7) 📜 Ver histórico/logs
echo   8) 📦 Gerenciar stashes
echo   9) 🔀 Gerenciar merges
echo  10) 🏷️  Gerenciar tags
echo.
echo   0) 🚪 Sair
echo.
echo ═══════════════════════════════════════
echo.
set /p "choice=Escolha uma opção: "

if "!choice!"=="1" (
    echo.
    set /p "commit_msg=Mensagem do commit (Enter para padrão): "
    call :run_script "git-commit" "!commit_msg!"
) else if "!choice!"=="2" (
    call :run_script "git-pull"
) else if "!choice!"=="3" (
    call :run_script "git-push"
) else if "!choice!"=="4" (
    echo.
    set /p "commit_msg=Mensagem do commit (Enter para padrão): "
    call :run_script "git-sync" "!commit_msg!"
) else if "!choice!"=="5" (
    call :run_script "git-branch"
) else if "!choice!"=="6" (
    echo.
    echo === STATUS DETALHADO ===
    echo.
    git status
    echo.
    echo === MUDANÇAS ===
    git diff --stat
) else if "!choice!"=="7" (
    call :run_script "git-log"
) else if "!choice!"=="8" (
    call :run_script "git-stash"
) else if "!choice!"=="9" (
    call :run_script "git-merge"
) else if "!choice!"=="10" (
    call :run_script "git-tag"
) else if "!choice!"=="0" (
    echo.
    echo 👋 Até logo!
    exit /b 0
) else (
    echo ❌ Opção inválida!
)

echo.
pause
goto :menu_loop

REM Função principal
:main
if "%~1"=="" (
    call :show_menu
    goto :eof
)

if "%~1"=="menu" (
    call :show_menu
    goto :eof
)

if "%~1"=="commit" (
    call :run_script "git-commit" %*
    goto :eof
)

if "%~1"=="comitar" (
    call :run_script "comitar" %*
    goto :eof
)

if "%~1"=="pull" (
    call :run_script "git-pull" %*
    goto :eof
)

if "%~1"=="push" (
    call :run_script "git-push" %*
    goto :eof
)

if "%~1"=="sync" (
    call :run_script "git-sync" %*
    goto :eof
)

if "%~1"=="branch" (
    call :run_script "git-branch" %*
    goto :eof
)

if "%~1"=="stash" (
    call :run_script "git-stash" %*
    goto :eof
)

if "%~1"=="merge" (
    call :run_script "git-merge" %*
    goto :eof
)

if "%~1"=="tag" (
    call :run_script "git-tag" %*
    goto :eof
)

if "%~1"=="log" (
    call :run_script "git-log" %*
    goto :eof
)

if "%~1"=="help" (
    call :show_help
    goto :eof
)

if "%~1"=="-h" (
    call :show_help
    goto :eof
)

if "%~1"=="--help" (
    call :show_help
    goto :eof
)

echo ❌ Comando '%~1' não reconhecido!
echo.
call :show_help
exit /b 1

REM Executa função principal
call :main %*

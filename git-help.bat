@echo off
REM Git Tools - Sistema de Ajuda para Windows
REM Uso: git-help.bat ou githelp

echo.
echo ================================================================
echo                    GIT TOOLS - AJUDA
echo              Sistema de Comandos Git
echo ================================================================
echo.

echo COMANDOS PRINCIPAIS:
echo   gitmenu     - Menu principal interativo
echo   gcommit     - Commit rapido
echo   gsync       - Sincronizacao completa
echo   gbranch     - Gerenciar branches
echo   gstash      - Gerenciar stashes
echo   gmerge      - Merge de branches
echo   gtag        - Gerenciar tags
echo   glog        - Ver historico
echo.

echo ALIASES CURTOS:
echo   gc          - Commit rapido (gcommit)
echo   gp          - Push (gpush)
echo   gl          - Pull (gpull)
echo   gs          - Sync (gsync)
echo   gb          - Branch (gbranch)
echo   gst         - Stash (gstash)
echo   gm          - Merge (gmerge)
echo   gt          - Tag (gtag)
echo   glg         - Log (glog)
echo.

echo COMANDOS ADICIONAIS:
echo   gcomitar    - Commit com interface amigavel
echo   gpull       - Pull (atualizar do remoto)
echo   gpush       - Push (enviar para remoto)
echo.

echo COMO USAR:
echo   gitmenu                    - Abre o menu principal
echo   gcommit "mensagem"        - Commit com mensagem
echo   gsync                     - Sincroniza com remoto
echo   gbranch                   - Gerencia branches
echo.

echo EXEMPLOS PRATICOS:
echo   gitmenu                    - Menu completo
echo   gcommit "feat: nova funcionalidade"
echo   gsync                     - Pull + Push automatico
echo   gbranch                   - Criar/alterar branches
echo   gstash save "trabalho em progresso"
echo.

echo INFORMACOES:
if exist "%USERPROFILE%\.git-tools-aliases" (
    echo   Aliases instalados globalmente
    echo   Localizacao: %USERPROFILE%\.git-tools-aliases
) else (
    echo   Aliases nao encontrados
    echo   Execute: install-git-tools.ps1
)

if exist "%USERPROFILE%\.git-tools" (
    echo   Scripts instalados em: %USERPROFILE%\.git-tools
) else (
    echo   Scripts nao encontrados
)
echo.

echo INSTALACAO:
echo   install-git-tools.ps1     - Instalar globalmente (PowerShell)
echo   install-git-tools.sh      - Instalar globalmente (Git Bash)
echo   git-tools-portable.bat    - Usar portatil (qualquer pasta)
echo.

echo MAIS AJUDA:
echo   gitmenu                    - Menu interativo completo
echo   INSTALACAO.md             - Documentacao de instalacao
echo   README-GIT-SCRIPTS.md     - Documentacao dos scripts
echo.

echo ================================================================
echo   DICA: Use 'gitmenu' para acessar o menu principal!
echo ================================================================
echo.
pause

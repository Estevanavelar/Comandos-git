# Script de Instalacao Git Tools para Windows (PowerShell)
# Execute como: .\install-git-tools.ps1

param(
    [switch]$Force
)

# Verifica se esta executando como administrador
function Test-Administrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Funcao para escrever com cores
function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

# Banner
Write-ColorOutput "==========================================" "Cyan"
Write-ColorOutput "        INSTALADOR GIT TOOLS           " "Cyan"
Write-ColorOutput "         Windows PowerShell            " "Cyan"
Write-ColorOutput "==========================================" "Cyan"
Write-Host ""

# Verifica se esta no diretorio correto
if (-not (Test-Path "git-menu.sh")) {
    Write-ColorOutput "ERRO: Execute este script no diretorio dos Git Tools!" "Red"
    Write-ColorOutput "Navegue ate a pasta 'Comandos git' e execute novamente." "Yellow"
    exit 1
}

Write-ColorOutput "Configurando Git Tools para Windows..." "Blue"

# Cria diretorio de instalacao global
$installDir = "$env:USERPROFILE\.git-tools"
if (-not (Test-Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir -Force | Out-Null
}

# Copia todos os scripts para o diretorio global
Write-ColorOutput "Copiando scripts para $installDir..." "Yellow"
Copy-Item "*.sh" $installDir -Force
Copy-Item "*.bat" $installDir -Force

# Cria arquivo de configuração global
$configFile = "$installDir\git-tools-config.json"
$configContent = @{
    "install_dir" = $installDir
    "scripts_dir" = $installDir
    "version" = "2.0"
    "installed_at" = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    "auto_update" = $true
} | ConvertTo-Json -Depth 3

$configContent | Out-File -FilePath $configFile -Encoding UTF8
Write-ColorOutput "Arquivo de configuração criado: $configFile" "Green"

# Cria arquivo de perfil PowerShell
$profilePath = $PROFILE.CurrentUserAllHosts
$profileDir = Split-Path $profilePath -Parent

if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}

# Cria arquivo de aliases PowerShell
$aliasesFile = "$installDir\git-tools-aliases.ps1"
Write-ColorOutput "Criando arquivo de aliases PowerShell..." "Yellow"

# Função para executar scripts bash do Git
function Invoke-GitScript {
    param(
        [string]$ScriptName,
        [string[]]$Arguments = @()
    )
    
    $scriptPath = "$installDir\$ScriptName.sh"
    if (Test-Path $scriptPath) {
        # Usa o bash do Git para executar scripts .sh
        $gitBash = "${env:ProgramFiles}\Git\bin\bash.exe"
        if (Test-Path $gitBash) {
            & $gitBash $scriptPath @Arguments
        } else {
            # Fallback para WSL ou Git for Windows em localização diferente
            $gitBash = "${env:ProgramFiles(x86)}\Git\bin\bash.exe"
            if (Test-Path $gitBash) {
                & $gitBash $scriptPath @Arguments
            } else {
                Write-Error "Git Bash não encontrado! Instale o Git for Windows."
            }
        }
    } else {
        Write-Error "Script $ScriptName.sh não encontrado em $installDir"
    }
}

$aliasesContent = @"
# Git Tools - Aliases Globais para PowerShell
# Carregado automaticamente pelo perfil
# Funciona de qualquer pasta do sistema

# Configuração global
`$GIT_TOOLS_DIR = "$installDir"

# Função para executar scripts bash do Git
function Invoke-GitScript {
    param(
        [string]`$ScriptName,
        [string[]]`$Arguments = @()
    )
    
    `$scriptPath = "`$GIT_TOOLS_DIR\`$ScriptName.sh"
    if (Test-Path `$scriptPath) {
        # Usa o bash do Git para executar scripts .sh
        `$gitBash = "`${env:ProgramFiles}\Git\bin\bash.exe"
        if (Test-Path `$gitBash) {
            & `$gitBash `$scriptPath @Arguments
        } else {
            # Fallback para WSL ou Git for Windows em localização diferente
            `$gitBash = "`${env:ProgramFiles(x86)}\Git\bin\bash.exe"
            if (Test-Path `$gitBash) {
                & `$gitBash `$scriptPath @Arguments
            } else {
                Write-Error "Git Bash não encontrado! Instale o Git for Windows."
            }
        }
    } else {
        Write-Error "Script `$ScriptName.sh não encontrado em `$GIT_TOOLS_DIR"
    }
}

# Menu principal
function gitmenu { Invoke-GitScript "git-menu" `$args }
Set-Alias -Name gmenu -Value gitmenu

# Operacoes basicas
function gcommit { Invoke-GitScript "git-commit" `$args }
function gcomitar { Invoke-GitScript "git-commit" `$args }
function gpull { Invoke-GitScript "git-pull" `$args }
function gpush { Invoke-GitScript "git-push" `$args }
function gsync { Invoke-GitScript "git-sync" `$args }

# Gerenciamento
function gbranch { Invoke-GitScript "git-branch" `$args }
function gstash { Invoke-GitScript "git-stash" `$args }
function gmerge { Invoke-GitScript "git-merge" `$args }
function gtag { Invoke-GitScript "git-tag" `$args }
function glog { Invoke-GitScript "git-log" `$args }

# Aliases curtos (apenas os que não conflitam com comandos existentes)
Set-Alias -Name gs -Value gsync
Set-Alias -Name gb -Value gbranch
Set-Alias -Name gst -Value gstash
Set-Alias -Name gt -Value gtag
Set-Alias -Name glg -Value glog

# Comando de ajuda
function githelp { Invoke-GitScript "git-help" `$args }
Set-Alias -Name ghelp -Value githelp
Set-Alias -Name help -Value githelp

# Função para iniciar edição
function gstart { Invoke-GitScript "git-start-editing" `$args }
Set-Alias -Name gedit -Value gstart

# Função para verificar status
function gstatus { 
    Write-Host "📊 Git Tools - Status Global" -ForegroundColor Cyan
    Write-Host "📁 Diretório de instalação: `$GIT_TOOLS_DIR" -ForegroundColor White
    Write-Host "✅ Scripts disponíveis:" -ForegroundColor Green
    
    `$scripts = @("git-menu", "git-commit", "git-pull", "git-push", "git-sync", 
                  "git-branch", "git-stash", "git-merge", "git-tag", "git-log", 
                  "git-help", "git-start-editing")
    
    foreach (`$script in `$scripts) {
        if (Test-Path "`$GIT_TOOLS_DIR\`$script.sh") {
            Write-Host "   ✅ `$script.sh" -ForegroundColor Green
        } else {
            Write-Host "   ❌ `$script.sh" -ForegroundColor Red
        }
    }
    
    Write-Host "`n🚀 Use 'githelp' para ver todos os comandos!" -ForegroundColor Yellow
}

Write-Host "🚀 Git Tools v2.0 carregado globalmente!" -ForegroundColor Green
Write-Host "💡 Use 'gitmenu' para começar ou 'githelp' para ajuda." -ForegroundColor Cyan
Write-Host "📊 Use 'gstatus' para verificar o status da instalação." -ForegroundColor Blue
"@

$aliasesContent | Out-File -FilePath $aliasesFile -Encoding UTF8

# Adiciona ao perfil PowerShell
Write-ColorOutput "Configurando perfil PowerShell..." "Blue"
$profileContent = Get-Content $profilePath -ErrorAction SilentlyContinue

if ($profileContent -and $profileContent -match "git-tools-aliases") {
    Write-ColorOutput "Git Tools ja configurado no perfil PowerShell" "Yellow"
} else {
    Add-Content $profilePath "`n# Git Tools - Configuracao automatica"
    Add-Content $profilePath ". '$aliasesFile'"
    Write-ColorOutput "Configuracao adicionada ao perfil PowerShell" "Green"
}

# Cria arquivo de lote para CMD
$batchFile = "$installDir\git-tools.bat"
$batchContent = @"
@echo off
REM Git Tools - Carregador para CMD
REM Adicione este arquivo ao PATH ou execute diretamente

if "%1"=="" (
    echo Git Tools - Comandos disponiveis:
    echo   gitmenu    - Menu principal
    echo   gcommit    - Commit rapido
    echo   gsync      - Sincronizacao completa
    echo   gbranch    - Gerenciar branches
    echo   gstash     - Gerenciar stashes
    echo   githelp    - Ver ajuda completa
    echo.
    echo Exemplo: git-tools.bat gitmenu
) else (
    "%~dp0%1.bat" %2 %3 %4 %5 %6 %7 %8 %9
)
"@

$batchContent | Out-File -FilePath $batchFile -Encoding ASCII

# Cria script de desinstalacao
$uninstallScript = "$installDir\uninstall.ps1"
$uninstallContent = @"
# Script de desinstalacao Git Tools
Write-Host "Desinstalando Git Tools..." -ForegroundColor Yellow

# Remove do perfil PowerShell
`$profilePath = `$PROFILE.CurrentUserAllHosts
`$profileContent = Get-Content `$profilePath -ErrorAction SilentlyContinue
if (`$profileContent) {
    `$newContent = `$profileContent | Where-Object { `$_ -notmatch "git-tools" }
    Set-Content `$profilePath `$newContent
}

# Remove diretorio
Remove-Item "$installDir" -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "Git Tools desinstalado com sucesso!" -ForegroundColor Green
"@

$uninstallContent | Out-File -FilePath $uninstallScript -Encoding UTF8

Write-Host ""
Write-ColorOutput "INSTALACAO CONCLUIDA!" "Green"
Write-Host ""
Write-ColorOutput "PROXIMOS PASSOS:" "Cyan"
Write-ColorOutput "1. Reinicie o PowerShell ou execute: . '$aliasesFile'" "White"
Write-ColorOutput "2. Use os comandos em qualquer pasta:" "White"
Write-ColorOutput "   - gitmenu (menu principal)" "White"
Write-ColorOutput "   - gcommit (commit rapido)" "White"
Write-ColorOutput "   - gsync (sincronizacao completa)" "White"
Write-ColorOutput "   - gbranch (gerenciar branches)" "White"
Write-ColorOutput "   - githelp (ver ajuda completa)" "White"
Write-Host ""
Write-ColorOutput "TESTE AGORA:" "Green"
Write-ColorOutput "   'githelp' - Para ver todos os comandos" "White"
Write-ColorOutput "   'gitmenu' - Para abrir o menu principal" "White"
Write-Host ""
Write-ColorOutput "DICA: Use 'gitmenu' para acessar o menu principal!" "Yellow"
Write-ColorOutput "DICA: Use 'githelp' para ver todos os comandos!" "Yellow"
Write-Host ""
Write-ColorOutput "Para desinstalar: . '$uninstallScript'" "Blue"
Write-ColorOutput "Scripts instalados em: $installDir" "Blue"
Write-ColorOutput "Para CMD: $batchFile" "Blue"

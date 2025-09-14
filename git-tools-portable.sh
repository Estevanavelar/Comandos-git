#!/bin/bash

# Git Tools Portátil para Linux/macOS - Funciona em qualquer pasta
# Uso: ./git-tools-portable.sh [comando] [opções]

# Cores para o terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Diretório onde está este arquivo
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Verifica se há uma instalação global do Git Tools
GLOBAL_INSTALL_DIR="$HOME/.git-tools"
if [ -d "$GLOBAL_INSTALL_DIR" ]; then
    echo -e "${GREEN}✅ Instalação global do Git Tools encontrada!${NC}"
    echo -e "${BLUE}📁 Usando scripts de: $GLOBAL_INSTALL_DIR${NC}"
    SCRIPT_DIR="$GLOBAL_INSTALL_DIR"
else
    echo -e "${YELLOW}⚠️  Instalação global não encontrada, usando versão portátil.${NC}"
    echo -e "${BLUE}💡 Para instalar globalmente, execute: ./install-git-tools.sh${NC}"
    echo -e "${BLUE}📁 Usando scripts de: $SCRIPT_DIR${NC}"
fi

# Verifica se Git está instalado
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Erro: Git não está instalado!${NC}"
    echo -e "${YELLOW}Instale o Git:${NC}"
    echo -e "${WHITE}  Ubuntu/Debian: sudo apt install git${NC}"
    echo -e "${WHITE}  CentOS/RHEL: sudo yum install git${NC}"
    echo -e "${WHITE}  macOS: brew install git${NC}"
    exit 1
fi

# Função para mostrar banner
show_banner() {
    echo ""
    echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║        GIT TOOLS PORTÁTIL             ║${NC}"
    echo -e "${CYAN}║         Linux/macOS                    ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
    echo ""
}

# Função para mostrar ajuda
show_help() {
    show_banner
    echo -e "${BLUE}📋 COMANDOS DISPONÍVEIS:${NC}"
    echo ""
    echo -e "${GREEN}🎯 OPERAÇÕES BÁSICAS:${NC}"
    echo -e "${WHITE}  menu     - Menu interativo principal${NC}"
    echo -e "${WHITE}  start    - Iniciar edição (com branch nova)${NC}"
    echo -e "${WHITE}  commit   - Commit rápido${NC}"
    echo -e "${WHITE}  comitar  - Commit alternativo${NC}"
    echo -e "${WHITE}  pull     - Atualizar do remoto${NC}"
    echo -e "${WHITE}  push     - Enviar para remoto${NC}"
    echo -e "${WHITE}  sync     - Sincronização completa${NC}"
    echo ""
    echo -e "${GREEN}🌿 GERENCIAMENTO:${NC}"
    echo -e "${WHITE}  branch   - Gerenciar branches${NC}"
    echo -e "${WHITE}  stash    - Gerenciar stashes${NC}"
    echo -e "${WHITE}  merge    - Gerenciar merges${NC}"
    echo -e "${WHITE}  tag      - Gerenciar tags${NC}"
    echo -e "${WHITE}  log      - Ver histórico/logs${NC}"
    echo ""
    echo -e "${GREEN}💡 EXEMPLOS DE USO:${NC}"
    echo -e "${WHITE}  ./git-tools-portable.sh menu${NC}"
    echo -e "${WHITE}  ./git-tools-portable.sh start${NC}"
    echo -e "${WHITE}  ./git-tools-portable.sh commit \"feat: nova funcionalidade\"${NC}"
    echo -e "${WHITE}  ./git-tools-portable.sh sync \"atualizações do dia\"${NC}"
    echo -e "${WHITE}  ./git-tools-portable.sh branch${NC}"
    echo ""
    echo -e "${YELLOW}💡 DICA: Execute sem parâmetros para ver este menu!${NC}"
}

# Função para verificar se está em repositório Git
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo -e "${RED}❌ Erro: Não está em um repositório Git!${NC}"
        echo ""
        echo -e "${BLUE}Opções:${NC}"
        echo -e "${WHITE}1) Inicializar novo repositório aqui${NC}"
        echo -e "${WHITE}2) Clonar repositório existente${NC}"
        echo -e "${WHITE}3) Sair${NC}"
        echo ""
        read -p "Escolha uma opção: " init_choice
        
        case $init_choice in
            1)
                git init
                echo -e "${GREEN}✅ Repositório Git inicializado!${NC}"
                echo ""
                ;;
            2)
                echo ""
                read -p "URL do repositório: " repo_url
                if [ -n "$repo_url" ]; then
                    git clone "$repo_url"
                    echo -e "${GREEN}✅ Repositório clonado!${NC}"
                    echo -e "${YELLOW}Entre no diretório clonado e execute o script novamente.${NC}"
                else
                    echo -e "${RED}❌ URL vazia!${NC}"
                fi
                exit 0
                ;;
            3)
                exit 0
                ;;
            *)
                echo -e "${RED}❌ Opção inválida!${NC}"
                exit 1
                ;;
        esac
    fi
}

# Função para executar script
run_script() {
    local script_name="$1"
    shift
    local script_path="$SCRIPT_DIR/$script_name.sh"
    
    # Verifica se há uma instalação global primeiro
    if [ -f "$GLOBAL_INSTALL_DIR/$script_name.sh" ]; then
        script_path="$GLOBAL_INSTALL_DIR/$script_name.sh"
        echo -e "${GREEN}✅ Usando script global: $script_name.sh${NC}"
    elif [ -f "$script_path" ]; then
        echo -e "${GREEN}✅ Usando script local: $script_name.sh${NC}"
    else
        echo -e "${RED}❌ Script $script_name.sh não encontrado!${NC}"
        echo -e "${YELLOW}Verificando localizações:${NC}"
        echo -e "${WHITE}  Global: $GLOBAL_INSTALL_DIR/$script_name.sh${NC}"
        echo -e "${WHITE}  Local: $script_path${NC}"
        echo ""
        echo -e "${BLUE}💡 Execute ./install-git-tools.sh para instalação global${NC}"
        exit 1
    fi
    
    # Executa o script encontrado
    bash "$script_path" "$@"
}

# Função para menu interativo
show_menu() {
    while true; do
        clear
        show_banner
        check_git_repo
        
        echo ""
        echo -e "${BLUE}📊 Status do Repositório:${NC}"
        
        # Obtém informações do repositório
        local repo_name=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null)
        local current_branch=$(git branch --show-current 2>/dev/null)
        
        echo -e "${WHITE}📁 Diretório: $repo_name${NC}"
        echo -e "${WHITE}🌿 Branch atual: $current_branch${NC}"
        
        # Verifica se há mudanças
        if git status --porcelain > /dev/null 2>&1; then
            if [ -n "$(git status --porcelain)" ]; then
                echo -e "${WHITE}📝 Status: Mudanças pendentes${NC}"
            else
                echo -e "${WHITE}📝 Status: Limpo${NC}"
            fi
        fi
        
        echo ""
        echo -e "${CYAN}═══════════════════════════════════════${NC}"
        echo ""
        echo -e "${GREEN}🚀 INICIAR TRABALHO:${NC}"
        echo -e "${WHITE}  1) 🌿 Iniciar edição (com branch nova)${NC}"
        echo ""
        echo -e "${GREEN}📋 OPERAÇÕES BÁSICAS:${NC}"
        echo -e "${WHITE}  2) 💾 Commit rápido${NC}"
        echo -e "${WHITE}  3) 📥 Pull (atualizar do remoto)${NC}"
        echo -e "${WHITE}  4) 📤 Push (enviar para remoto)${NC}"
        echo -e "${WHITE}  5) 🔄 Sync (sincronização completa)${NC}"
        echo ""
        echo -e "${GREEN}🌿 GERENCIAMENTO:${NC}"
        echo -e "${WHITE}  6) 📑 Gerenciar branches${NC}"
        echo -e "${WHITE}  7) 📊 Ver status detalhado${NC}"
        echo -e "${WHITE}  8) 📜 Ver histórico/logs${NC}"
        echo -e "${WHITE}  9) 📦 Gerenciar stashes${NC}"
        echo -e "${WHITE} 10) 🔀 Gerenciar merges${NC}"
        echo -e "${WHITE} 11) 🏷️  Gerenciar tags${NC}"
        echo ""
        echo -e "${WHITE}  0) 🚪 Sair${NC}"
        echo ""
        echo -e "${CYAN}═══════════════════════════════════════${NC}"
        echo ""
        read -p "Escolha uma opção: " choice
        
        case $choice in
            1)
                run_script "git-start-editing"
                ;;
            2)
                echo ""
                read -p "Mensagem do commit (Enter para padrão): " commit_msg
                run_script "git-commit" "$commit_msg"
                ;;
            3)
                run_script "git-pull"
                ;;
            4)
                run_script "git-push"
                ;;
            5)
                echo ""
                read -p "Mensagem do commit (Enter para padrão): " commit_msg
                run_script "git-sync" "$commit_msg"
                ;;
            6)
                run_script "git-branch"
                ;;
            7)
                echo ""
                echo -e "${BLUE}=== STATUS DETALHADO ===${NC}"
                echo ""
                git status
                echo ""
                echo -e "${BLUE}=== MUDANÇAS ===${NC}"
                git diff --stat
                ;;
            8)
                run_script "git-log"
                ;;
            9)
                run_script "git-stash"
                ;;
            10)
                run_script "git-merge"
                ;;
            11)
                run_script "git-tag"
                ;;
            0)
                echo ""
                echo -e "${GREEN}👋 Até logo!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ Opção inválida!${NC}"
                ;;
        esac
        
        echo ""
        read -p "Pressione Enter para continuar..."
    done
}

# Função principal
main() {
    case "$1" in
        "")
            show_menu
            ;;
        "menu")
            show_menu
            ;;
        "start")
            run_script "git-start-editing" "${@:2}"
            ;;
        "commit")
            run_script "git-commit" "${@:2}"
            ;;
        "comitar")
            run_script "git-commit" "${@:2}"
            ;;
        "pull")
            run_script "git-pull" "${@:2}"
            ;;
        "push")
            run_script "git-push" "${@:2}"
            ;;
        "sync")
            run_script "git-sync" "${@:2}"
            ;;
        "branch")
            run_script "git-branch" "${@:2}"
            ;;
        "stash")
            run_script "git-stash" "${@:2}"
            ;;
        "merge")
            run_script "git-merge" "${@:2}"
            ;;
        "tag")
            run_script "git-tag" "${@:2}"
            ;;
        "log")
            run_script "git-log" "${@:2}"
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            echo -e "${RED}❌ Comando '$1' não reconhecido!${NC}"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# Executa função principal
main "$@"
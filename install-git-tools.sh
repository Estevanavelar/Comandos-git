#!/bin/bash

# Script de Instalação Git Tools para Linux/macOS
# Execute como: ./install-git-tools.sh

# Cores para o terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Banner
echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║        INSTALADOR GIT TOOLS           ║${NC}"
echo -e "${CYAN}║         Configuração Global            ║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
echo ""

# Verifica se está no diretório correto
if [ ! -f "git-menu.sh" ]; then
    echo -e "${RED}❌ Erro: Execute este script no diretório dos Git Tools!${NC}"
    echo -e "${YELLOW}Navegue até a pasta 'Comandos git' e execute novamente.${NC}"
    exit 1
fi

echo -e "${BLUE}🔧 Configurando Git Tools globalmente...${NC}"

# Cria diretório de instalação global
INSTALL_DIR="$HOME/.git-tools"
mkdir -p "$INSTALL_DIR"

# Copia todos os scripts para o diretório global
echo -e "${YELLOW}📁 Copiando scripts para $INSTALL_DIR...${NC}"
cp *.sh "$INSTALL_DIR/"
cp *.bat "$INSTALL_DIR/" 2>/dev/null || true

# Torna os scripts executáveis
chmod +x "$INSTALL_DIR"/*.sh

# Cria arquivo de configuração global
CONFIG_FILE="$INSTALL_DIR/git-tools-config.json"
echo -e "${YELLOW}📝 Criando arquivo de configuração...${NC}"
cat > "$CONFIG_FILE" << EOF
{
    "install_dir": "$INSTALL_DIR",
    "scripts_dir": "$INSTALL_DIR",
    "version": "2.0",
    "installed_at": "$(date '+%Y-%m-%d %H:%M:%S')",
    "auto_update": true,
    "platform": "linux"
}
EOF
echo -e "${GREEN}✅ Arquivo de configuração criado: $CONFIG_FILE${NC}"

# Cria arquivo de aliases
ALIASES_FILE="$HOME/.git-tools-aliases"
echo -e "${YELLOW}📝 Criando arquivo de aliases...${NC}"

cat > "$ALIASES_FILE" << 'EOF'
# Git Tools - Aliases Globais v2.0
# Funciona de qualquer pasta do sistema
# Carregado automaticamente pelo perfil

# Configuração global
GIT_TOOLS_DIR="$HOME/.git-tools"

# Função para executar scripts do Git Tools
git_exec() {
    local script_name="$1"
    shift
    local script_path="$GIT_TOOLS_DIR/$script_name.sh"
    
    if [ -f "$script_path" ]; then
        bash "$script_path" "$@"
    else
        echo "❌ Erro: Script $script_name.sh não encontrado em $GIT_TOOLS_DIR"
        return 1
    fi
}

# Menu principal
gitmenu() { git_exec "git-menu" "$@"; }
alias gmenu='gitmenu'

# Operações básicas
gcommit() { git_exec "git-commit" "$@"; }
gcomitar() { git_exec "git-commit" "$@"; }
gpull() { git_exec "git-pull" "$@"; }
gpush() { git_exec "git-push" "$@"; }
gsync() { git_exec "git-sync" "$@"; }

# Gerenciamento
gbranch() { git_exec "git-branch" "$@"; }
gstash() { git_exec "git-stash" "$@"; }
gmerge() { git_exec "git-merge" "$@"; }
gtag() { git_exec "git-tag" "$@"; }
glog() { git_exec "git-log" "$@"; }

# Aliases curtos (apenas os que não conflitam com comandos existentes)
alias gs='gsync'
alias gb='gbranch'
alias gst='gstash'
alias gt='gtag'
alias glg='glog'

# Comando de ajuda
githelp() { git_exec "git-help" "$@"; }
alias ghelp='githelp'
alias help='githelp'

# Função para iniciar edição
gstart() { git_exec "git-start-editing" "$@"; }
alias gedit='gstart'

# Função para verificar status da instalação
gstatus() {
    echo "📊 Git Tools - Status Global"
    echo "📁 Diretório de instalação: $GIT_TOOLS_DIR"
    echo "✅ Scripts disponíveis:"
    
    local scripts=("git-menu" "git-commit" "git-pull" "git-push" "git-sync" 
                   "git-branch" "git-stash" "git-merge" "git-tag" "git-log" 
                   "git-help" "git-start-editing")
    
    for script in "${scripts[@]}"; do
        if [ -f "$GIT_TOOLS_DIR/$script.sh" ]; then
            echo "   ✅ $script.sh"
        else
            echo "   ❌ $script.sh"
        fi
    done
    
    echo ""
    echo "🚀 Use 'githelp' para ver todos os comandos!"
}

# Função para atualizar Git Tools
gupdate() {
    echo "🔄 Atualizando Git Tools..."
    
    if [ -d "$GIT_TOOLS_DIR" ]; then
        cd "$GIT_TOOLS_DIR" || return 1
        
        # Backup da configuração
        if [ -f "git-tools-config.json" ]; then
            cp "git-tools-config.json" "git-tools-config.json.backup"
        fi
        
        echo "✅ Git Tools atualizado!"
        echo "💡 Reinicie o terminal ou execute: source ~/.git-tools-aliases"
    else
        echo "❌ Git Tools não está instalado!"
        echo "Execute o script de instalação primeiro."
    fi
}

echo "🚀 Git Tools v2.0 carregado globalmente!"
echo "💡 Use 'gitmenu' para começar ou 'githelp' para ajuda."
echo "📊 Use 'gstatus' para verificar o status da instalação."
echo "🔄 Use 'gupdate' para atualizar os scripts."
EOF

echo -e "${GREEN}✅ Arquivo de aliases criado: $ALIASES_FILE${NC}"

# Tenta encontrar e configurar o arquivo de configuração do shell
SHELL_CONFIG=""
if [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [ -f "$HOME/.profile" ]; then
    SHELL_CONFIG="$HOME/.profile"
fi

if [ -n "$SHELL_CONFIG" ]; then
    if grep -q "git-tools-aliases" "$SHELL_CONFIG"; then
        echo -e "${YELLOW}⚠️  Git Tools já configurado em $SHELL_CONFIG${NC}"
    else
        echo "" >> "$SHELL_CONFIG"
        echo "# Git Tools - Configuração automática" >> "$SHELL_CONFIG"
        echo "source \"$ALIASES_FILE\"" >> "$SHELL_CONFIG"
        echo -e "${GREEN}✅ Configuração adicionada a $SHELL_CONFIG${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Arquivo de configuração do shell não encontrado${NC}"
    echo -e "${YELLOW}Configure manualmente adicionando 'source \"$ALIASES_FILE\"' ao seu arquivo de configuração${NC}"
fi

# Cria script de desinstalação
UNINSTALL_SCRIPT="$INSTALL_DIR/uninstall.sh"
cat > "$UNINSTALL_SCRIPT" << 'EOF'
#!/bin/bash
echo "Desinstalando Git Tools..."

# Remove do arquivo de configuração do shell
SHELL_CONFIG=""
if [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [ -f "$HOME/.profile" ]; then
    SHELL_CONFIG="$HOME/.profile"
fi

if [ -n "$SHELL_CONFIG" ]; then
    # Remove linhas relacionadas ao Git Tools
    sed -i '/git-tools/d' "$SHELL_CONFIG"
    sed -i '/Git Tools/d' "$SHELL_CONFIG"
fi

# Remove arquivo de aliases
rm -f "$HOME/.git-tools-aliases"

# Remove diretório de instalação
rm -rf "$HOME/.git-tools"

echo "✅ Git Tools desinstalado com sucesso!"
EOF

chmod +x "$UNINSTALL_SCRIPT"

# ATIVAÇÃO AUTOMÁTICA DOS ALIASES
echo -e "${BLUE}🚀 Ativando aliases automaticamente...${NC}"
source "$ALIASES_FILE"

echo ""
echo -e "${GREEN}🎉 INSTALAÇÃO CONCLUÍDA!${NC}"
echo ""
echo -e "${CYAN}📋 ALIASES ATIVADOS AUTOMATICAMENTE:${NC}"
echo -e "${WHITE}✅ gitmenu - Menu principal${NC}"
echo -e "${WHITE}✅ gcommit - Commit rápido${NC}"
echo -e "${WHITE}✅ gsync - Sincronização completa${NC}"
echo -e "${WHITE}✅ gbranch - Gerenciar branches${NC}"
echo -e "${WHITE}✅ githelp - Ver ajuda completa${NC}"
echo ""
echo -e "${GREEN}🎯 TESTE AGORA:${NC}"
echo -e "${WHITE}\"githelp\"${NC} - Para ver todos os comandos"
echo -e "${WHITE}\"gitmenu\"${NC} - Para abrir o menu principal"
echo ""
echo -e "${YELLOW}💡 DICA: Os aliases já estão funcionando! Não precisa reiniciar o terminal.${NC}"
echo -e "${YELLOW}💡 DICA: Para ativar manualmente: source \"$ALIASES_FILE\"${NC}"
echo ""
echo -e "${BLUE}🔧 Para desinstalar: $UNINSTALL_SCRIPT${NC}"
echo -e "${BLUE}📁 Scripts instalados em: $INSTALL_DIR${NC}"
echo -e "${BLUE}📝 Aliases configurados em: $ALIASES_FILE${NC}"
echo -e "${BLUE}📝 Comando para ativar: source \"$ALIASES_FILE\"${NC}"

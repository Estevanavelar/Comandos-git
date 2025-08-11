#!/bin/bash

# Script de Instalação - Git Tools
# Uso: ./install-git-tools.sh

# Cores para melhor visualização
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}"
echo "╔════════════════════════════════════════╗"
echo "║        INSTALADOR GIT TOOLS           ║"
echo "║         Configuração Global            ║"
echo "╚════════════════════════════════════════╝"
echo -e "${NC}"

# Verifica se está no diretório correto
if [ ! -f "git-menu.sh" ]; then
    echo -e "${RED}❌ Erro: Execute este script no diretório dos Git Tools!${NC}"
    echo "Navegue até a pasta 'Comandos git' e execute novamente."
    exit 1
fi

echo -e "${BLUE}🔧 Configurando Git Tools globalmente...${NC}"

# Cria diretório de instalação global
INSTALL_DIR="$HOME/.git-tools"
mkdir -p "$INSTALL_DIR"

# Copia todos os scripts para o diretório global
echo "📁 Copiando scripts para $INSTALL_DIR..."
cp *.sh "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR"/*.sh

# Cria arquivo de configuração de aliases
ALIAS_FILE="$HOME/.git-tools-aliases"
echo -e "${YELLOW}📝 Criando arquivo de aliases...${NC}"

cat > "$ALIAS_FILE" << 'EOF'
# Git Tools - Aliases Globais
# Adicione este conteúdo ao seu ~/.bashrc, ~/.zshrc ou ~/.profile

# Menu principal
alias gitmenu='~/.git-tools/git-menu.sh'

# Operações básicas
alias gcommit='~/.git-tools/git-commit.sh'
alias gcomitar='~/.git-tools/comitar.sh'
alias gpull='~/.git-tools/git-pull.sh'
alias gpush='~/.git-tools/git-push.sh'
alias gsync='~/.git-tools/git-sync.sh'

# Gerenciamento
alias gbranch='~/.git-tools/git-branch.sh'
alias gstash='~/.git-tools/git-stash.sh'
alias gmerge='~/.git-tools/git-merge.sh'
alias gtag='~/.git-tools/git-tag.sh'
alias glog='~/.git-tools/git-log.sh'

# Aliases curtos
alias gc='gcommit'
alias gp='gpush'
alias gl='gpull'
alias gs='gsync'
alias gb='gbranch'
alias gst='gstash'
alias gm='gmerge'
alias gt='gtag'
alias glg='glog'
EOF

echo -e "${GREEN}✅ Arquivo de aliases criado: $ALIAS_FILE${NC}"

# Detecta o shell e configura automaticamente
SHELL_CONFIG=""
if [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
    SHELL_NAME="bash"
elif [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
    SHELL_NAME="zsh"
elif [ -f "$HOME/.profile" ]; then
    SHELL_CONFIG="$HOME/.profile"
    SHELL_NAME="profile"
fi

if [ ! -z "$SHELL_CONFIG" ]; then
    echo -e "${YELLOW}🔍 Shell detectado: $SHELL_NAME${NC}"
    
    # Verifica se já tem os aliases configurados
    if grep -q "git-tools-aliases" "$SHELL_CONFIG"; then
        echo -e "${YELLOW}⚠️  Aliases já configurados em $SHELL_CONFIG${NC}"
    else
        echo -e "${BLUE}📝 Adicionando configuração ao $SHELL_CONFIG...${NC}"
        echo "" >> "$SHELL_CONFIG"
        echo "# Git Tools - Configuração automática" >> "$SHELL_CONFIG"
        echo "source $ALIAS_FILE" >> "$SHELL_CONFIG"
        echo -e "${GREEN}✅ Configuração adicionada ao $SHELL_CONFIG${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Arquivo de configuração do shell não encontrado${NC}"
    echo "Configure manualmente adicionando 'source $ALIAS_FILE' ao seu arquivo de configuração"
fi

# Cria script de desinstalação
UNINSTALL_SCRIPT="$INSTALL_DIR/uninstall.sh"
cat > "$UNINSTALL_SCRIPT" << 'EOF'
#!/bin/bash
echo "Desinstalando Git Tools..."
rm -rf ~/.git-tools
rm -f ~/.git-tools-aliases
echo "Git Tools desinstalado com sucesso!"
EOF

chmod +x "$UNINSTALL_SCRIPT"

echo ""
echo -e "${GREEN}🎉 INSTALAÇÃO CONCLUÍDA!${NC}"
echo ""
echo -e "${CYAN}📋 PRÓXIMOS PASSOS:${NC}"
echo "1. Reinicie seu terminal ou execute: source $SHELL_CONFIG"
echo "2. Use os comandos em qualquer pasta:"
echo "   - gitmenu (menu principal)"
echo "   - gcommit (commit rápido)"
echo "   - gsync (sincronização completa)"
echo "   - gbranch (gerenciar branches)"
echo ""
echo -e "${YELLOW}💡 DICA: Use 'gitmenu' para acessar o menu principal!${NC}"
echo ""
echo -e "${BLUE}🔧 Para desinstalar: $UNINSTALL_SCRIPT${NC}"
echo -e "${BLUE}📁 Scripts instalados em: $INSTALL_DIR${NC}"

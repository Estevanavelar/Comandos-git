# 🚀 INSTALAÇÃO GIT TOOLS - Guia Completo

## 📋 **OPÇÕES DE INSTALAÇÃO DISPONÍVEIS**

### **1. 🎯 INSTALAÇÃO GLOBAL (RECOMENDADA)**
**Para usar em qualquer pasta com aliases globais**

#### **Linux/macOS:**
```bash
# 1. Navegue até a pasta dos Git Tools
cd "Comandos git"

# 2. Execute o instalador
chmod +x install-git-tools.sh
./install-git-tools.sh

# 3. Reinicie o terminal ou execute:
source ~/.bashrc  # ou ~/.zshrc
```

#### **Windows PowerShell:**
```powershell
# 1. Navegue até a pasta dos Git Tools
cd "Comandos git"

# 2. Execute o instalador (como administrador se necessário)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\install-git-tools.ps1

# 3. Reinicie o PowerShell
```

**✅ VANTAGENS:**
- Comandos disponíveis em qualquer pasta
- Aliases globais configurados automaticamente
- Funciona em todos os terminais
- Fácil de usar: `gitmenu`, `gcommit`, `gsync`

---

### **2. 🔧 SCRIPT PORTÁTIL (SEM INSTALAÇÃO)**
**Para usar em qualquer pasta sem instalação**

#### **Linux/macOS:**
```bash
# Copie para qualquer pasta e use:
./git-tools-portable.sh menu
./git-tools-portable.sh commit "feat: nova funcionalidade"
./git-tools-portable.sh sync "atualizações"
```

#### **Windows CMD:**
```cmd
# Copie para qualquer pasta e use:
git-tools-portable.bat menu
git-tools-portable.bat commit "feat: nova funcionalidade"
git-tools-portable.bat sync "atualizações"
```

**✅ VANTAGENS:**
- Não precisa instalar
- Funciona em qualquer pasta
- Portátil (pode copiar para pendrive)
- Menu interativo completo

---

## 🎮 **COMANDOS DISPONÍVEIS APÓS INSTALAÇÃO**

### **📋 OPERAÇÕES BÁSICAS:**
```bash
gitmenu    # Menu interativo principal
gcommit    # Commit rápido
gcomitar   # Commit alternativo
gpull      # Atualizar do remoto
gpush      # Enviar para remoto
gsync      # Sincronização completa
```

### **🌿 GERENCIAMENTO:**
```bash
gbranch    # Gerenciar branches
gstash     # Gerenciar stashes
gmerge     # Gerenciar merges
gtag       # Gerenciar tags
glog       # Ver histórico/logs
```

### **⚡ ALIASES CURTOS:**
```bash
gc         # gcommit
gp         # gpush
gl         # gpull
gs         # gsync
gb         # gbranch
gst        # gstash
gm         # gmerge
gt         # gtag
glg        # glog
```

---

## 🛠️ **CONFIGURAÇÃO MANUAL (OPCIONAL)**

### **Para Bash (.bashrc):**
```bash
# Adicione ao ~/.bashrc:
alias gitmenu='~/.git-tools/git-menu.sh'
alias gcommit='~/.git-tools/git-commit.sh'
alias gsync='~/.git-tools/git-sync.sh'
# ... outros aliases
```

### **Para Zsh (.zshrc):**
```bash
# Adicione ao ~/.zshrc:
alias gitmenu='~/.git-tools/git-menu.sh'
alias gcommit='~/.git-tools/git-commit.sh'
alias gsync='~/.git-tools/git-sync.sh'
# ... outros aliases
```

### **Para PowerShell:**
```powershell
# Adicione ao perfil:
Set-Alias -Name gitmenu -Value "~\.git-tools\git-menu.sh"
Set-Alias -Name gcommit -Value "~\.git-tools\git-commit.sh"
Set-Alias -Name gsync -Value "~\.git-tools\git-sync.sh"
# ... outros aliases
```

---

## 🔍 **VERIFICAÇÃO DA INSTALAÇÃO**

### **Teste se está funcionando:**
```bash
# 1. Abra um novo terminal
# 2. Navegue para qualquer pasta
# 3. Execute:
gitmenu

# 4. Ou teste um comando específico:
gcommit "teste de instalação"
```

### **Se não funcionar:**
```bash
# 1. Verifique se os aliases estão carregados:
alias | grep git

# 2. Recarregue o perfil:
source ~/.bashrc  # ou ~/.zshrc

# 3. Verifique se os scripts estão no lugar certo:
ls -la ~/.git-tools/
```

---

## 🗑️ **DESINSTALAÇÃO**

### **Linux/macOS:**
```bash
~/.git-tools/uninstall.sh
```

### **Windows PowerShell:**
```powershell
. ~\.git-tools\uninstall.ps1
```

### **Manual:**
```bash
# 1. Remova o diretório:
rm -rf ~/.git-tools

# 2. Remova os aliases do perfil:
# Edite ~/.bashrc, ~/.zshrc ou perfil PowerShell
# Remova as linhas relacionadas ao git-tools
```

---

## 🚨 **REQUISITOS**

### **Sistema:**
- ✅ Git instalado e configurado
- ✅ Bash (Linux/macOS) ou PowerShell/CMD (Windows)
- ✅ Permissões de execução nos scripts

### **Git:**
```bash
# Verifique se o Git está instalado:
git --version

# Configure usuário e email (se necessário):
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"
```

---

## 💡 **DICAS DE USO**

### **🔄 Fluxo de Trabalho Diário:**
```bash
# Início do dia:
gpull      # Atualizar do remoto

# Durante o trabalho:
gstash     # Salvar mudanças temporárias

# Final do dia:
gsync      # Commit e push automático
```

### **🌿 Gerenciamento de Branches:**
```bash
gbranch    # Menu interativo para branches
gitmenu    # Menu principal com todas as opções
```

### **📦 Stash Inteligente:**
```bash
gstash     # Salvar, aplicar e gerenciar stashes
```

---

## 🆘 **SUPORTE**

### **Problemas Comuns:**
1. **"Comando não encontrado"** → Recarregue o terminal
2. **"Permissão negada"** → Execute `chmod +x *.sh`
3. **"Git não instalado"** → Instale o Git primeiro

### **Logs e Debug:**
```bash
# Verifique se os scripts estão executáveis:
ls -la *.sh

# Teste um script específico:
./git-menu.sh

# Verifique o PATH:
echo $PATH
```

---

## 🎉 **PRONTO PARA USAR!**

Após a instalação, você terá acesso a todos os comandos Git de forma simples e intuitiva, com menus interativos e automação completa!

**Use `gitmenu` para começar e explore todas as funcionalidades! 🚀**

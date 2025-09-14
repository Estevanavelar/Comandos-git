# 🚀 Git Tools - Instalação Global

Este documento explica como instalar e configurar o Git Tools para funcionar **globalmente** em qualquer pasta do sistema, sem precisar ter os arquivos nos seus projetos.

## 📋 Pré-requisitos

- **Git** instalado no sistema
- **PowerShell** (Windows) ou **Bash/Zsh** (Linux/macOS)
- Permissões de administrador (Windows) ou sudo (Linux)

## 🪟 Windows

### Instalação Automática

1. **Navegue até a pasta do Git Tools:**
   ```powershell
   cd "C:\Projetos\Comandos git"
   ```

2. **Execute o instalador:**
   ```powershell
   .\install-git-tools.ps1
   ```

3. **Reinicie o PowerShell** ou execute:
   ```powershell
   . "$env:USERPROFILE\.git-tools\git-tools-aliases.ps1"
   ```

### Verificação da Instalação

```powershell
# Verificar se os comandos estão funcionando
githelp
gstatus

# Testar um comando
gitmenu
```

## 🐧 Linux/macOS

### Instalação Automática

1. **Navegue até a pasta do Git Tools:**
   ```bash
   cd "/caminho/para/Comandos git"
   ```

2. **Execute o instalador:**
   ```bash
   ./install-git-tools.sh
   ```

3. **Reinicie o terminal** ou execute:
   ```bash
   source ~/.git-tools-aliases
   ```

### Verificação da Instalação

```bash
# Verificar se os comandos estão funcionando
githelp
gstatus

# Testar um comando
gitmenu
```

## 🎯 Como Funciona

### Estrutura de Instalação

```
~/.git-tools/                    # Linux/macOS
%USERPROFILE%\.git-tools\        # Windows
├── git-menu.sh
├── git-commit.sh
├── git-pull.sh
├── git-push.sh
├── git-sync.sh
├── git-branch.sh
├── git-stash.sh
├── git-merge.sh
├── git-tag.sh
├── git-log.sh
├── git-help.sh
├── git-start-editing.sh
├── git-tools-config.json
└── git-tools-aliases.ps1       # Windows
```

### Aliases Globais

Após a instalação, você terá acesso aos seguintes comandos **de qualquer pasta**:

#### 🎯 Operações Básicas
- `gitmenu` - Menu principal interativo
- `gcommit` - Commit rápido
- `gpull` - Atualizar do remoto
- `gpush` - Enviar para remoto
- `gsync` - Sincronização completa

#### 🌿 Gerenciamento
- `gbranch` - Gerenciar branches
- `gstash` - Gerenciar stashes
- `gmerge` - Gerenciar merges
- `gtag` - Gerenciar tags
- `glog` - Ver histórico/logs

#### 🔧 Utilitários
- `githelp` - Ajuda completa
- `gstatus` - Status da instalação
- `gstart` - Iniciar edição com nova branch

#### ⚡ Aliases Curtos
- `gs` → `gsync`
- `gb` → `gbranch`
- `gst` → `gstash`
- `gt` → `gtag`
- `glg` → `glog`

**Nota:** Aliases como `gc`, `gp`, `gl`, `gm` foram removidos para evitar conflitos com comandos existentes do sistema.

## 🔄 Versão Portátil

Se você não quiser instalar globalmente, ainda pode usar a versão portátil:

### Windows
```cmd
git-tools-portable.bat menu
git-tools-portable.bat commit "minha mensagem"
```

### Linux/macOS
```bash
./git-tools-portable.sh menu
./git-tools-portable.sh commit "minha mensagem"
```

**Vantagem:** A versão portátil detecta automaticamente se há uma instalação global e a usa, caso contrário usa a versão local.

## 🛠️ Comandos de Manutenção

### Verificar Status
```bash
gstatus                    # Linux/macOS
gstatus                    # Windows (PowerShell)
```

### Atualizar Git Tools
```bash
gupdate                    # Linux/macOS
# Windows: Execute install-git-tools.ps1 novamente
```

### Desinstalar
```bash
# Linux/macOS
~/.git-tools/uninstall.sh

# Windows
. "$env:USERPROFILE\.git-tools\uninstall.ps1"
```

## 🎯 Exemplos de Uso

### Cenário 1: Projeto Novo
```bash
mkdir meu-projeto
cd meu-projeto
git init
gstart "feature/nova-funcionalidade"
# Trabalhar no código...
gcommit "feat: implementa nova funcionalidade"
gpush
```

### Cenário 2: Projeto Existente
```bash
cd projeto-existente
gpull
gbranch
# Criar nova branch
gcommit "fix: corrige bug crítico"
gsync "correção de emergência"
```

### Cenário 3: Trabalho Colaborativo
```bash
cd projeto-equipe
gpull
gbranch
# Ver branches disponíveis
gstash
# Salvar trabalho temporariamente
gpull
# Atualizar com mudanças do time
gstash pop
# Restaurar trabalho
gmerge
# Fazer merge da branch
```

## 🔧 Solução de Problemas

### Windows - PowerShell Execution Policy
Se encontrar erro de política de execução:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Linux - Permissões
Se os scripts não forem executáveis:
```bash
chmod +x ~/.git-tools/*.sh
```

### Comandos não encontrados
```bash
# Verificar se o perfil foi carregado
gstatus

# Recarregar manualmente
source ~/.git-tools-aliases        # Linux/macOS
. "$env:USERPROFILE\.git-tools\git-tools-aliases.ps1"  # Windows
```

## 🎉 Vantagens da Instalação Global

1. **✅ Funciona de qualquer pasta** - Não precisa copiar arquivos para projetos
2. **✅ Comandos simples** - `gcommit` em vez de `./git-commit.sh`
3. **✅ Auto-atualização** - Atualize uma vez, funciona em todos os projetos
4. **✅ Integração com shell** - Aliases e funções nativas
5. **✅ Backup automático** - Configurações salvas em local seguro
6. **✅ Compatibilidade** - Funciona com PowerShell, Bash, Zsh

## 📞 Suporte

Se encontrar problemas:

1. Execute `gstatus` para verificar a instalação
2. Execute `githelp` para ver todos os comandos
3. Verifique se o Git está instalado: `git --version`
4. Consulte os logs de instalação

---

**🎯 Agora você pode usar `gcommit`, `gpull`, `gpush` e todos os outros comandos de qualquer pasta do seu sistema!**

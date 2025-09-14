# 📚 Índice - Git Tools

Este é o arquivo índice principal que contém instruções para navegar por toda a documentação do projeto Git Tools.

## 📋 Documentação Principal

### 🚀 Instalação e Configuração
- **[INSTALACAO-GLOBAL.md](./INSTALACAO-GLOBAL.md)** - Guia completo para instalação global do Git Tools
- **[INSTALACAO.md](./INSTALACAO.md)** - Documentação de instalação básica (versão anterior)

### 📖 Documentação de Uso
- **[README.md](./README.md)** - Documentação principal do projeto
- **[README-PORTATIL.md](./README-PORTATIL.md)** - Documentação da versão portátil (movido para .lixeira)

## 🔧 Scripts de Instalação

### Windows
- **[install-git-tools.ps1](./install-git-tools.ps1)** - Instalador principal para Windows (PowerShell)
- **[install-git-tools.bat](./install-git-tools.bat)** - Instalador alternativo para Windows (CMD)

### Linux/macOS
- **[install-git-tools.sh](./install-git-tools.sh)** - Instalador para Linux e macOS

## 🎯 Scripts Portáteis

### Versões Portáteis (Funcionam sem instalação)
- **[git-tools-portable.bat](./git-tools-portable.bat)** - Versão portátil para Windows
- **[git-tools-portable.sh](./git-tools-portable.sh)** - Versão portátil para Linux/macOS

## 📁 Scripts Individuais

### Operações Básicas
- **[git-menu.sh](./git-menu.sh)** - Menu principal interativo
- **[git-commit.sh](./git-commit.sh)** - Commit rápido
- **[git-pull.sh](./git-pull.sh)** - Atualizar do repositório remoto
- **[git-push.sh](./git-push.sh)** - Enviar para repositório remoto
- **[git-sync.sh](./git-sync.sh)** - Sincronização completa

### Gerenciamento
- **[git-branch.sh](./git-branch.sh)** - Gerenciar branches
- **[git-stash.sh](./git-stash.sh)** - Gerenciar stashes
- **[git-merge.sh](./git-merge.sh)** - Gerenciar merges
- **[git-tag.sh](./git-tag.sh)** - Gerenciar tags
- **[git-log.sh](./git-log.sh)** - Ver histórico e logs

### Utilitários
- **[git-help.sh](./git-help.sh)** - Sistema de ajuda
- **[git-start-editing.sh](./git-start-editing.sh)** - Iniciar edição com nova branch

### Versões Windows (.bat)
- **[git-commit.bat](./git-commit.bat)** - Versão Windows do commit
- **[git-help.bat](./git-help.bat)** - Versão Windows da ajuda
- **[git-log.bat](./git-log.bat)** - Versão Windows dos logs
- **[git-menu.bat](./git-menu.bat)** - Versão Windows do menu
- **[git-merge.bat](./git-merge.bat)** - Versão Windows do merge
- **[git-stash.bat](./git-stash.bat)** - Versão Windows do stash
- **[git-sync.bat](./git-sync.bat)** - Versão Windows da sincronização
- **[git-tag.bat](./git-tag.bat)** - Versão Windows das tags
- **[git-start-editing.bat](./git-start-editing.bat)** - Versão Windows do start editing

## 📂 Arquivos Arquivados

### Pasta .lixeira
Arquivos movidos para a pasta `.lixeira/` (não são mais necessários):
- `git-tools-portable.zip` - Arquivo compactado antigo
- `install-portable.bat` - Instalador portátil antigo para Windows
- `install-portable.sh` - Instalador portátil antigo para Linux
- `README-PORTATIL.md` - Documentação portátil antiga

## 🎯 Guia de Início Rápido

### Para Usar Globalmente (Recomendado)
1. Leia **[INSTALACAO-GLOBAL.md](./INSTALACAO-GLOBAL.md)**
2. Execute o instalador apropriado para seu sistema
3. Use os comandos de qualquer pasta: `gcommit`, `gpull`, `gpush`, etc.

### Para Usar Portátil
1. Use **[git-tools-portable.bat](./git-tools-portable.bat)** (Windows)
2. Use **[git-tools-portable.sh](./git-tools-portable.sh)** (Linux/macOS)
3. Execute: `./git-tools-portable.sh menu`

### Para Desenvolvedores
1. Todos os scripts `.sh` são a fonte principal
2. Scripts `.bat` são versões Windows dos principais
3. Scripts portáteis detectam instalação global automaticamente

## 🔄 Atualizações

- **v2.0** - Instalação global melhorada, comandos funcionam de qualquer pasta
- **v1.0** - Versão inicial com scripts básicos

## 📞 Suporte

- Execute `githelp` para ver todos os comandos disponíveis
- Execute `gstatus` para verificar o status da instalação
- Consulte a documentação específica para cada funcionalidade

---

**💡 Dica:** Comece sempre lendo **[INSTALACAO-GLOBAL.md](./INSTALACAO-GLOBAL.md)** para a melhor experiência!

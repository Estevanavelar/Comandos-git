# 🚀 Scripts de Automação Git

Este conjunto de scripts automatiza as operações mais comuns do Git, facilitando o trabalho diário com repositórios.

## 📋 Scripts Disponíveis

### 1. **git-menu.sh** - Menu Principal Interativo
Menu principal com todas as funcionalidades disponíveis.
```bash
./git-menu.sh
```

### 2. **git-commit.sh** - Commit Rápido
Adiciona todas as mudanças e faz commit.
```bash
./git-commit.sh "mensagem do commit"
# ou apenas
./git-commit.sh
```

### 2.1. **comitar.sh** - Commit Rápido (Alternativo)
Versão alternativa com nome mais curto.
```bash
./comitar.sh "mensagem do commit"
# ou apenas
./comitar.sh
```

### 3. **git-pull.sh** - Atualizar do Remoto
Baixa as últimas atualizações do repositório remoto.
```bash
./git-pull.sh
```

### 4. **git-push.sh** - Enviar para Remoto
Envia seus commits locais para o repositório remoto.
```bash
./git-push.sh
# ou especificar branch
./git-push.sh nome-do-branch
```

### 5. **git-sync.sh** - Sincronização Completa
Faz commit, pull e push em uma única operação.
```bash
./git-sync.sh "mensagem do commit"
# ou apenas
./git-sync.sh
```

### 6. **git-branch.sh** - Gerenciar Branches
Menu interativo para criar, trocar, deletar e fazer merge de branches.
```bash
./git-branch.sh
```

### 7. **git-stash.sh** - Gerenciar Stashes
Menu interativo para gerenciar stashes (salvamento temporário de mudanças).
```bash
./git-stash.sh
```

**Funcionalidades do git-stash.sh:**
- 📦 Criar stash com diferentes opções (normal, anotado, patch)
- 🔄 Aplicar stash (apply, pop, clear)
- 👁️ Visualizar conteúdo do stash
- 🗑️ Deletar stash específico ou todos
- 🌿 Criar branch a partir de stash

### 8. **git-tag.sh** - Gerenciar Tags
Menu interativo para gerenciar tags do repositório.
```bash
./git-tag.sh
```

**Funcionalidades do git-tag.sh:**
- 🏷️ Criar tags (leve, anotada, em commit específico)
- 📋 Listar tags com detalhes
- 🗑️ Deletar tags (local e remoto)
- 🔄 Fazer checkout de tag
- 📤 Enviar tags para remoto
- 🔍 Buscar tags remotas
- 👁️ Ver detalhes e estatísticas de tags

### 9. **git-log.sh** - Visualizador de Logs
Menu interativo para explorar o histórico do repositório.
```bash
./git-log.sh
```

**Funcionalidades do git-log.sh:**
- 📋 Logs básicos (10, 20, 50 commits ou todos)
- ⏰ Filtros por tempo (hoje, semana, mês, ano, datas específicas)
- 👤 Filtros por autor (nome, email, estatísticas)
- 💬 Filtros por mensagem (texto, regex, tipos de commit)
- 📁 Filtros por arquivo (histórico, modificações, extensões)
- 📊 Logs com gráfico (simples, branches, tags, estatísticas)
- 🔍 Logs detalhados (commit específico, diff, patches)
- 📤 Exportar logs (TXT, CSV, JSON)

### 10. **git-merge.sh** - Gerenciar Merges e Resolver Conflitos
Menu interativo para automatizar operações de merge com resolução inteligente de conflitos.
```bash
./git-merge.sh
```

**Funcionalidades do git-merge.sh:**
- 🔄 Merge simples entre branches
- 🔄 Merge com rebase
- 🔄 Merge de Pull Requests
- 🔄 Merge de múltiplos branches
- 🔄 Merge com squash
- 🔧 Resolução automática de conflitos
- 🧠 Resolução inteligente por tipo de arquivo
- 📊 Verificação de mudanças não commitadas
- 🛡️ Múltiplas estratégias de resolução de conflitos

## 🖥️ Como Usar no Windows

### Opção 1: Git Bash (Recomendado)
1. Abra o **Git Bash** no diretório onde estão os scripts
2. Execute qualquer script usando:
   ```bash
   ./nome-do-script.sh
   ```

### Opção 2: PowerShell com WSL
Se você tem o WSL (Windows Subsystem for Linux) instalado:
```powershell
wsl ./nome-do-script.sh
```

### Opção 3: Criar Atalhos .bat
Para facilitar, você pode criar arquivos .bat para cada script:

**git-menu.bat:**
```batch
@echo off
"C:\Program Files\Git\bin\bash.exe" git-menu.sh
pause
```

**comitar.bat:**
```batch
@echo off
"C:\Program Files\Git\bin\bash.exe" comitar.sh
pause
```

**git-stash.bat:**
```batch
@echo off
title Git Stash Manager
"C:\Program Files\Git\bin\bash.exe" git-stash.sh %*
pause
```

**git-tag.bat:**
```batch
@echo off
title Git Tag Manager
"C:\Program Files\Git\bin\bash.exe" git-tag.sh %*
pause
```

**git-log.bat:**
```batch
@echo off
title Git Log Viewer
"C:\Program Files\Git\bin\bash.exe" git-log.sh %*
pause
```

**git-merge.bat:**
```batch
@echo off
title Git Merge Manager
"C:\Program Files\Git\bin\bash.exe" git-merge.sh %*
pause
```

## 🔧 Configuração Inicial

1. **Primeira execução**: Execute o menu principal
   ```bash
   ./git-menu.sh
   ```

2. **Configuração do Git**: O menu oferece uma opção de configuração inicial que define:
   - Seu nome de usuário
   - Seu email

## 💡 Dicas de Uso

### Commit Rápido
```bash
# Com mensagem personalizada
./git-commit.sh "feat: adiciona nova funcionalidade"
# ou
./comitar.sh "feat: adiciona nova funcionalidade"

# Mensagem padrão com timestamp
./git-commit.sh
# ou
./comitar.sh
```

### Sincronização Completa
```bash
# Ideal para o final do dia de trabalho
./git-sync.sh "fix: correções do dia"
```

### Trabalhar com Branches
```bash
# Use o menu interativo
./git-branch.sh

# Opções disponíveis:
# - Criar novo branch
# - Trocar de branch (com opção de stash)
# - Deletar branch local/remoto
# - Fazer merge entre branches
```

### Gerenciar Stashes
```bash
# Menu interativo para stashes
./git-stash.sh

# Útil para:
# - Salvar mudanças temporariamente
# - Trocar de branch sem commit
# - Aplicar mudanças de outro contexto
```

### Gerenciar Tags
```bash
# Menu interativo para tags
./git-tag.sh

# Útil para:
# - Marcar versões do projeto
# - Criar releases
# - Navegar por pontos específicos do histórico
```

### Explorar Histórico
```bash
# Menu interativo para logs
./git-log.sh

# Útil para:
# - Encontrar commits específicos
# - Analisar contribuições por autor
# - Exportar histórico para relatórios
```

### Gerenciar Merges e Conflitos
```bash
# Menu interativo para merges
./git-merge.sh

# Útil para:
# - Fazer merge entre branches
# - Resolver conflitos automaticamente
# - Gerenciar Pull Requests
# - Merge de múltiplos branches
# - Squash merges para histórico limpo
```

## ⚡ Atalhos Úteis

### Criar aliases no Git Bash
Adicione ao arquivo `~/.bashrc`:

```bash
alias gc='./git-commit.sh'
alias gp='./git-push.sh'
alias gl='./git-pull.sh'
alias gs='./git-sync.sh'
alias gb='./git-branch.sh'
alias gm='./git-menu.sh'
# Novos scripts
alias gst='./git-stash.sh'
alias gt='./git-tag.sh'
alias glog='./git-log.sh'
alias gmrg='./git-merge.sh'
# Alternativas
alias c='./comitar.sh'
```

Depois execute:
```bash
source ~/.bashrc
```

## 🛡️ Recursos de Segurança

- **Verificação de repositório**: Scripts verificam se você está em um repositório Git
- **Confirmações**: Operações críticas pedem confirmação
- **Tratamento de conflitos**: Orientações claras quando há conflitos
- **Stash automático**: Opção de salvar mudanças temporariamente
- **Validações**: Verifica conexão com remoto antes de operações
- **Backup de dados**: Stash e tags são preservados até confirmação explícita
- **Verificações de existência**: Evita operações em recursos inexistentes

## 📊 Casos de Uso Comuns

### Fluxo de Desenvolvimento
1. **Início do dia**: `./git-pull.sh` para atualizar
2. **Durante o trabalho**: `./git-stash.sh` para salvar mudanças temporárias
3. **Final do dia**: `./git-sync.sh` para commit e push

### Gerenciamento de Versões
1. **Criar release**: `./git-tag.sh` para marcar versão
2. **Histórico**: `./git-log.sh` para analisar mudanças
3. **Deploy**: `./git-tag.sh` para fazer checkout da versão

### Resolução de Conflitos
1. **Stash mudanças**: `./git-stash.sh` para salvar trabalho atual
2. **Atualizar**: `./git-pull.sh` para resolver conflitos
3. **Aplicar stash**: `./git-stash.sh` para recuperar mudanças

## 📌 Observações

- Os scripts foram criados para funcionar com Git Bash no Windows
- Funcionam também em Linux e macOS
- Requerem Git instalado e configurado
- Mensagens com emojis para melhor visualização
- Todas as mensagens estão em português
- Scripts interativos com menus intuitivos
- Suporte completo a operações Git avançadas

## 🆘 Problemas Comuns

### "Permission denied"
No Git Bash, execute:
```bash
chmod +x *.sh
```

### "Command not found"
Certifique-se de estar no diretório correto e use `./` antes do nome do script

### Conflitos de Merge
Os scripts detectam conflitos e fornecem instruções para resolvê-los

### Stash não encontrado
Use `./git-stash.sh` para listar e gerenciar stashes disponíveis

### Tag não existe
Use `./git-tag.sh` para verificar tags disponíveis antes de operações

---

💻 **Desenvolvido para facilitar seu trabalho com Git!**

🚀 **Agora com 10 scripts especializados para todas as suas necessidades Git!**

#!/bin/bash

# Script para iniciar edição com criação automática de branch
# Uso: ./git-start-editing.sh

# Cores para melhor visualização
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}=== INICIAR EDIÇÃO COM BRANCH ===${NC}"

# Verifica se está em um repositório Git
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}❌ Erro: Não está em um repositório Git!${NC}"
    exit 1
fi

# Mostra status atual
echo ""
echo -e "${BLUE}📊 Status atual do repositório:${NC}"
echo -e "📁 Diretório: ${YELLOW}$(basename `git rev-parse --show-toplevel`)${NC}"
echo -e "🌿 Branch atual: ${GREEN}$(git branch --show-current)${NC}"

# Verifica se há mudanças não commitadas
if [ -n "$(git status --porcelain)" ]; then
    echo -e "📝 Status: ${YELLOW}Mudanças pendentes${NC}"
    echo ""
    echo -e "${YELLOW}⚠️  Existem mudanças não commitadas!${NC}"
    echo ""
    echo "O que deseja fazer com as mudanças atuais?"
    echo "1) Fazer commit antes de criar branch"
    echo "2) Fazer stash das mudanças"
    echo "3) Descartar mudanças (CUIDADO!)"
    echo "4) Cancelar"
    echo ""
    read -p "Escolha (1-4): " change_choice
    
    case $change_choice in
        1)
            echo ""
            read -p "Mensagem do commit: " commit_msg
            if [ -z "$commit_msg" ]; then
                commit_msg="Commit antes de criar nova branch - $(date '+%d/%m/%Y %H:%M:%S')"
            fi
            git add -A
            git commit -m "$commit_msg"
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✅ Commit realizado com sucesso!${NC}"
            else
                echo -e "${RED}❌ Erro ao fazer commit!${NC}"
                exit 1
            fi
            ;;
        2)
            git stash save "Stash antes de criar nova branch - $(date '+%d/%m/%Y %H:%M:%S')"
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✅ Stash criado com sucesso!${NC}"
            else
                echo -e "${RED}❌ Erro ao criar stash!${NC}"
                exit 1
            fi
            ;;
        3)
            read -p "⚠️  Tem certeza que deseja DESCARTAR as mudanças? (s/n): " confirm_discard
            if [ "$confirm_discard" = "s" ] || [ "$confirm_discard" = "S" ]; then
                git reset --hard HEAD
                git clean -fd
                echo -e "${GREEN}✅ Mudanças descartadas!${NC}"
            else
                echo -e "${YELLOW}Operação cancelada!${NC}"
                exit 0
            fi
            ;;
        4)
            echo -e "${YELLOW}Operação cancelada!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Opção inválida!${NC}"
            exit 1
            ;;
    esac
else
    echo -e "📝 Status: ${GREEN}Limpo${NC}"
fi

echo ""
echo -e "${PURPLE}═══════════════════════════════════════${NC}"
echo ""
echo "🚀 Como deseja iniciar a edição?"
echo ""
echo "1) 🌿 Criar nova branch para esta edição"
echo "2) ✏️  Continuar editando na branch atual"
echo "3) 🔄 Trocar para outra branch existente"
echo "0) 🚪 Cancelar"
echo ""
read -p "Escolha uma opção: " main_choice

case $main_choice in
    1)
        # Criar nova branch
        echo ""
        echo -e "${CYAN}=== CRIAR NOVA BRANCH ===${NC}"
        
        # Atualiza repositório remoto
        if git remote -v | grep -q origin; then
            echo ""
            echo -e "${BLUE}🔄 Atualizando informações do repositório remoto...${NC}"
            git fetch origin --quiet
            echo -e "${GREEN}✅ Repositório atualizado!${NC}"
        fi
        
        echo ""
        echo "📝 Tipo de branch:"
        echo "1) 🆕 feature/ - Nova funcionalidade"
        echo "2) 🐛 bugfix/ - Correção de bug"
        echo "3) 🔧 fix/ - Correção rápida"
        echo "4) 📚 docs/ - Documentação"
        echo "5) 🎨 style/ - Melhorias de estilo/formatação"
        echo "6) ⚡ perf/ - Melhorias de performance"
        echo "7) 🧪 test/ - Adição de testes"
        echo "8) 🔨 refactor/ - Refatoração"
        echo "9) 📝 Sem prefixo (nome personalizado)"
        echo ""
        read -p "Escolha o tipo (1-9): " type_choice
        
        case $type_choice in
            1) prefix="feature/" ;;
            2) prefix="bugfix/" ;;
            3) prefix="fix/" ;;
            4) prefix="docs/" ;;
            5) prefix="style/" ;;
            6) prefix="perf/" ;;
            7) prefix="test/" ;;
            8) prefix="refactor/" ;;
            9) prefix="" ;;
            *) 
                echo -e "${RED}❌ Opção inválida!${NC}"
                exit 1
                ;;
        esac
        
        echo ""
        if [ -n "$prefix" ]; then
            read -p "Nome da branch (será ${prefix}nome): " branch_suffix
            branch_name="${prefix}${branch_suffix}"
        else
            read -p "Nome completo da branch: " branch_name
        fi
        
        if [ -z "$branch_name" ] || [ -z "${branch_name#${prefix}}" ]; then
            echo -e "${RED}❌ Nome da branch não pode ser vazio!${NC}"
            exit 1
        fi
        
        # Verifica se a branch já existe
        if git show-ref --verify --quiet refs/heads/$branch_name; then
            echo -e "${RED}❌ Branch '$branch_name' já existe!${NC}"
            exit 1
        fi
        
        echo ""
        echo "🌱 Criar branch a partir de:"
        echo "1) Branch atual ($(git branch --show-current))"
        echo "2) main/master (mais atualizado)"
        echo "3) Outro branch específico"
        echo ""
        read -p "Escolha (1-3): " from_choice
        
        case $from_choice in
            1)
                git checkout -b $branch_name
                ;;
            2)
                # Detecta se é main ou master
                if git show-ref --verify --quiet refs/heads/main; then
                    base_branch="main"
                elif git show-ref --verify --quiet refs/heads/master; then
                    base_branch="master"
                else
                    echo -e "${RED}❌ Branch main/master não encontrado!${NC}"
                    exit 1
                fi
                
                # Atualiza o branch base se existir remoto
                if git show-ref --verify --quiet refs/remotes/origin/$base_branch; then
                    echo -e "${BLUE}🔄 Atualizando branch $base_branch...${NC}"
                    git checkout $base_branch --quiet
                    git pull origin $base_branch --quiet
                fi
                
                git checkout -b $branch_name $base_branch
                ;;
            3)
                echo ""
                echo "Branches disponíveis:"
                git branch -a
                echo ""
                read -p "Nome do branch de origem: " source_branch
                
                # Remove prefixo origin/ se fornecido
                source_branch=${source_branch#origin/}
                
                git checkout -b $branch_name $source_branch
                ;;
            *)
                echo -e "${RED}❌ Opção inválida!${NC}"
                exit 1
                ;;
        esac
        
        if [ $? -eq 0 ]; then
            echo ""
            echo -e "${GREEN}✅ Branch '$branch_name' criado e ativado!${NC}"
            
            # Pergunta se quer fazer push
            if git remote -v | grep -q origin; then
                echo ""
                read -p "🚀 Deseja fazer push do novo branch para o remoto? (s/n): " push_branch
                if [ "$push_branch" = "s" ] || [ "$push_branch" = "S" ]; then
                    git push -u origin $branch_name
                    if [ $? -eq 0 ]; then
                        echo -e "${GREEN}✅ Branch enviado para o remoto!${NC}"
                    else
                        echo -e "${YELLOW}⚠️  Branch criado localmente, mas falha ao enviar para remoto${NC}"
                    fi
                fi
            fi
            
            echo ""
            echo -e "${GREEN}🎉 Pronto para começar a edição!${NC}"
            echo -e "📝 Você está agora na branch: ${CYAN}$branch_name${NC}"
            
        else
            echo -e "${RED}❌ Erro ao criar branch!${NC}"
            exit 1
        fi
        ;;
        
    2)
        # Continuar na branch atual
        current_branch=$(git branch --show-current)
        echo ""
        echo -e "${GREEN}✅ Continuando edição na branch atual: ${CYAN}$current_branch${NC}"
        
        # Verifica se há atualizações remotas
        if git remote -v | grep -q origin; then
            if git show-ref --verify --quiet refs/remotes/origin/$current_branch; then
                echo ""
                read -p "🔄 Deseja atualizar a branch atual com as mudanças remotas? (s/n): " update_current
                if [ "$update_current" = "s" ] || [ "$update_current" = "S" ]; then
                    git pull origin $current_branch
                    if [ $? -eq 0 ]; then
                        echo -e "${GREEN}✅ Branch atualizada!${NC}"
                    else
                        echo -e "${YELLOW}⚠️  Pode haver conflitos para resolver${NC}"
                    fi
                fi
            fi
        fi
        ;;
        
    3)
        # Trocar para outra branch
        echo ""
        echo -e "${CYAN}=== TROCAR DE BRANCH ===${NC}"
        echo ""
        echo "📋 Branches disponíveis:"
        git branch -a
        echo ""
        
        read -p "Nome da branch: " target_branch
        
        if [ -z "$target_branch" ]; then
            echo -e "${RED}❌ Nome da branch não pode ser vazio!${NC}"
            exit 1
        fi
        
        # Remove prefixo origin/ se fornecido
        target_branch=${target_branch#origin/}
        
        # Verifica se é um branch remoto
        if git show-ref --verify --quiet refs/remotes/origin/$target_branch; then
            if ! git show-ref --verify --quiet refs/heads/$target_branch; then
                echo -e "${BLUE}🔄 Criando branch local a partir do remoto...${NC}"
                git checkout -b $target_branch origin/$target_branch
            else
                git checkout $target_branch
                # Atualiza com remoto se necessário
                read -p "🔄 Deseja atualizar com mudanças remotas? (s/n): " update_branch
                if [ "$update_branch" = "s" ] || [ "$update_branch" = "S" ]; then
                    git pull origin $target_branch
                fi
            fi
        else
            git checkout $target_branch
        fi
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Mudou para a branch '$target_branch'!${NC}"
        else
            echo -e "${RED}❌ Erro ao trocar de branch!${NC}"
            exit 1
        fi
        ;;
        
    0)
        echo -e "${YELLOW}👋 Operação cancelada!${NC}"
        exit 0
        ;;
        
    *)
        echo -e "${RED}❌ Opção inválida!${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${PURPLE}═══════════════════════════════════════${NC}"
echo ""
echo -e "${GREEN}🎯 RESUMO:${NC}"
echo -e "📁 Repositório: ${YELLOW}$(basename `git rev-parse --show-toplevel`)${NC}"
echo -e "🌿 Branch ativa: ${CYAN}$(git branch --show-current)${NC}"
echo -e "📝 Status: ${GREEN}Pronto para edição!${NC}"
echo ""
echo -e "${BLUE}💡 Próximos passos sugeridos:${NC}"
echo "   1. Faça suas alterações nos arquivos"
echo "   2. Use 'git status' para ver mudanças"
echo "   3. Use './git-commit.sh' para commit rápido"
echo "   4. Use './git-push.sh' para enviar mudanças"
echo ""
echo -e "${GREEN}✨ Boa edição!${NC}"

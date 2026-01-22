# Sistema de Pedidos de Venda

Sistema desktop desenvolvido em Delphi para controle de pedidos de venda,
com injeção de cadastro de clientes e produtos, permitindo criação e manutenção de pedidos
com múltiplos itens, controle de totalização e persistência em banco Firebird.

O projeto foi desenvolvido como desafio técnico, priorizando organização,
boas práticas, separação de responsabilidades e clareza de código.

---

## 🛠 Tecnologias Utilizadas

- Delphi 12 (Community Edition)
- Firebird SQL
- FireDAC
- DUnitX (testes unitários)

---

## 🧱 Arquitetura e Organização

O sistema foi estruturado com separação clara de responsabilidades:

- **UI (Forms)**  
  Responsável apenas pela interação com o usuário.

- **Services**  
  Contêm as regras de negócio, validações e controle transacional.

- **Repositories**  
  Responsáveis pelo acesso a dados e persistência no banco.

- **Entidades (Models)**  
  Representam o domínio da aplicação (Cliente, Produto, Pedido, PedidoItem).

A comunicação entre camadas é feita via **interfaces**, facilitando manutenção,
testes e futuras extensões do sistema.

---

## ⚙️ Inicialização Automática do Banco de Dados

O sistema **não exige execução manual de scripts SQL** para funcionar.

Ao iniciar a aplicação, é executado um fluxo automático de bootstrap:

1. Verifica se existe configuração de banco
2. Tenta conectar ao banco configurado
3. Caso o banco não exista:
   - Pergunta ao usuário se deseja criá-lo automaticamente
4. Caso a conexão falhe, ou não exista arquivo de configurações criado:
   - Abre automaticamente a tela de configurações
5. Caso tudo esteja correto:
   - O sistema inicia normalmente

Esse fluxo garante que o sistema seja executável mesmo em um ambiente limpo.

---

## 🔄 Manutenções da Base de Dados

O sistema possui uma rotina de **manutenção evolutiva da base**, garantindo que:

- Novos campos
- Ajustes estruturais
- Evoluções futuras

sejam aplicados automaticamente, mesmo quando o banco já existe.

Isso evita inconsistências entre versões da aplicação e da base de dados.

---

## 📋 Funcionalidades

- Consulta de clientes
- Consulta de produtos
- Criação de pedidos de venda
- Inclusão, edição e exclusão de itens do pedido
- Cálculo automático do total do pedido
- Cancelamento de pedidos
- Carregamento e edição de pedidos existentes
- Controle transacional durante gravações
- Configuração de base de dados dinâmica

---

## 💰 Totalização

- O valor total do pedido é calculado automaticamente
- Cada item possui total próprio (quantidade × valor unitário)
- O total do pedido é a soma dos totais dos itens

---

## 🧪 Testes Unitários

Foram implementados testes unitários utilizando **DUnitX** para validação
das regras de totalização.

Os testes contemplam:

- Totalização correta de itens
- Totalização correta de pedidos
- Cenários de sucesso
- Cenários de falha proposital (para demonstrar comportamento dos testes)

Esses testes demonstram o uso básico e correto da ferramenta.

---

## ▶️ Como Executar

1. Abrir o projeto no Delphi
2. Executar a aplicação
3. Caso necessário, configurar os dados de conexão ao banco
4. O sistema se encarrega do restante automaticamente

---

## 📂 Estrutura Geral do Projeto

- `src/` — código principal da aplicação
- `tests/` — projeto e unidades de testes (DUnitX)
- `db.sql` — script de referência da estrutura do banco (documentação)

---

## ✅ Roteiro rápido de testes manuais (passo a passo)

### 1) Primeira execução / Bootstrap do banco
1. Execute o sistema em um ambiente sem banco configurado.
2. Verifique se o sistema abre a tela de **Configurações** automaticamente (ou pergunta sobre criação do banco quando aplicável).
3. Preencha os campos de conexão e clique em **Salvar**.
4. Reinicie o sistema (se o fluxo exigir) e confirme que a aplicação abre normalmente.

**Resultado esperado:** sistema inicia com banco pronto, tabelas criadas e dados seed disponíveis.

---

### 2) Criar um novo pedido e gravar
1. No campo **Cliente**, informe um código válido (ex.: `1`) e saia do campo.
2. No campo **Produto**, informe um código válido (ex.: `1`) e saia do campo.
3. Preencha **Quantidade** e **Valor unitário**.
4. Clique em **Adicionar Produto**.
5. Repita para adicionar pelo menos 2 itens.
6. Clique em **Gravar**.

**Resultado esperado:** pedido é gravado, exibe mensagem com o número do pedido e a tela é limpa.

---

### 3) Carregar pedido e editar item
1. Clique em **Carregar** e informe o número de um pedido existente.
2. Selecione uma linha no grid de itens e pressione **Enter**.
3. Altere **Quantidade** e/ou **Valor unitário**.
4. Clique em **Atualizar Produto**.
5. Clique em **Gravar**.

**Resultado esperado:** item é atualizado no grid, total é recalculado e persistido no banco.

---

### 4) Excluir item do pedido
1. Com um pedido carregado (ou em edição), selecione um item no grid.
2. Pressione **Del** e confirme.
3. Verifique o **Total do Pedido** atualizado.
4. Clique em **Gravar**.

**Resultado esperado:** item removido do grid e removido do banco após gravar.

---

### 5) Cancelar pedido
1. Carregue um pedido existente.
2. Clique em **Cancelar** e confirme.

**Resultado esperado:** pedido e itens são excluídos do banco e a tela é limpa.

---

### 6) Validações rápidas
1. Tente **Gravar** sem informar cliente.
2. Tente **Gravar** sem itens no grid.
3. Informe um código de cliente/produto inexistente e saia do campo.

**Resultado esperado:** sistema exibe mensagens de validação e impede gravação/ações inválidas.

---

> Observação: o escopo original do desafio está disponível na pasta `/docs` apenas para referência.
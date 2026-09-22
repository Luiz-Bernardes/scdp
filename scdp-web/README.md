# SCDP Web

Frontend do Sistema Corporativo de Pausas.

Construído utilizando Next.js, React e TypeScript.

O frontend é responsável pela interface do sistema e pela comunicação com a SCDP API.

## Stack

* Next.js
* React
* TypeScript
* Tailwind CSS
* Axios

## Estrutura

```text
scdp-web/
├── src/
│   ├── app/
│   ├── components/
│   ├── hooks/
│   ├── lib/
│   ├── services/
│   └── types/
│
├── public/
├── package.json
└── ...
```

## Principais diretórios

### `src/app`

Contém as rotas do Next.js.

As páginas administrativas ficam em:

```text
src/app/admin/
```

Exemplo:

```text
admin/
├── users/
├── teams/
├── team-memberships/
└── pause-types/
```

Cada módulo segue a estrutura de rotas:

```text
<modulo>/
├── page.tsx
├── new/
│   └── page.tsx
└── [id]/
    └── edit/
        └── page.tsx
```

## Components

Os componentes reutilizáveis ficam em:

```text
src/components/
```

Os componentes administrativos são organizados por módulo:

```text
src/components/admin/
├── users/
├── teams/
├── team-memberships/
└── pause-types/
```

Cada módulo possui uma estrutura semelhante:

```text
pause-types/
├── form/
├── pages/
├── table/
└── index.ts
```

## Pages

As páginas de cada módulo ficam separadas dos componentes de rota.

Por exemplo:

```text
src/components/admin/pause-types/pages/
├── PauseTypesPage.tsx
├── NewPauseTypePage.tsx
└── EditPauseTypePage.tsx
```

A rota do Next.js apenas encaminha para o componente correspondente.

Exemplo:

```text
src/app/admin/pause-types/page.tsx
        ↓
PauseTypesPage
```

## Forms

Os formulários ficam em:

```text
components/admin/<module>/form/
```

Exemplo:

```text
PauseTypeForm.tsx
```

O mesmo formulário pode ser utilizado para criação e edição através da propriedade:

```ts
mode="create"
```

ou:

```ts
mode="edit"
```

## Tables

As tabelas seguem uma estrutura simples:

```text
<Module>Table
      ↓
<Module>TableRow
      ↓
Delete<Module>Button
```

Exemplo:

```text
PauseTypesTable
    ↓
PauseTypeTableRow
    ↓
DeletePauseTypeButton
```

A separação mantém a implementação simples e facilita a manutenção individual de cada parte.

## Hooks

Os hooks administrativos ficam em:

```text
src/hooks/admin/
```

Normalmente cada módulo possui três hooks principais:

```text
use<Module>
use<Modules>
use<Module>Actions
```

Por exemplo:

```text
usePauseType
usePauseTypes
usePauseTypeActions
```

### `usePauseTypes`

Responsável pela listagem:

```ts
const {
  pauseTypes,
  loading,
  refresh
} = usePauseTypes();
```

### `usePauseType`

Responsável pela consulta de um registro:

```ts
const {
  pauseType,
  loading
} = usePauseType(id);
```

### `usePauseTypeActions`

Responsável pelas operações:

```text
create
update
delete
```

## Services

Os services ficam em:

```text
src/services/admin/
```

Cada módulo possui seu próprio service.

Exemplo:

```text
pause-type-service.ts
```

O service é responsável pela comunicação HTTP com a API.

Exemplo:

```ts
api.get("/admin/pause_types");
```

ou:

```ts
api.post(
  "/admin/pause_types",
  {
    pause_type: params
  }
);
```

## Types

Os tipos utilizados pelo frontend ficam em:

```text
src/types/
```

Os tipos administrativos ficam agrupados em:

```text
src/types/admin
```

Exemplo:

```ts
AdminPauseType
AdminTeam
AdminUser
```

Os types representam os dados retornados pela API.

## Comunicação com a API

As requisições são realizadas através do cliente HTTP definido em:

```text
src/lib/api
```

Os componentes não devem realizar diretamente as chamadas HTTP.

O fluxo esperado é:

```text
Page
 ↓
Hook
 ↓
Service
 ↓
API
```

Por exemplo:

```text
PauseTypesPage
      ↓
usePauseTypes
      ↓
getAdminPauseTypes
      ↓
GET /admin/pause_types
```

## Executando o projeto

Entre no projeto:

```bash
cd ~/Desenvolvimento/scdp/scdp-web
```

Instale as dependências:

```bash
npm install
```

Execute o servidor de desenvolvimento:

```bash
npm run dev
```

O frontend ficará disponível no endereço padrão do Next.js:

```text
http://localhost:3000
```

A API também deve estar executando para que as operações administrativas funcionem.

## Desenvolvimento simultâneo

Normalmente são utilizados dois terminais:

### Terminal 1 — API

```bash
cd ~/Desenvolvimento/scdp/scdp-api
bin/rails server
```

### Terminal 2 — Web

```bash
cd ~/Desenvolvimento/scdp/scdp-web
npm run dev
```

Fluxo:

```text
Browser
   │
   ▼
SCDP Web
   │
   │ HTTP
   ▼
SCDP API
   │
   ▼
PostgreSQL
```

## Módulos administrativos atuais

O frontend possui as seguintes áreas:

```text
/admin/users
/admin/teams
/admin/team-memberships
/admin/pause-types
```

Cada uma possui operações de:

```text
Listagem
Criação
Edição
Remoção
```

## Padrão de implementação

Ao criar um novo módulo administrativo, seguir a estrutura existente.

### Components

```text
components/admin/<module>/
├── table/
│   ├── <Module>Table.tsx
│   ├── <Module>TableRow.tsx
│   └── Delete<Module>Button.tsx
│
├── form/
│   └── <Module>Form.tsx
│
├── pages/
│   ├── <Module>Page.tsx
│   ├── New<Module>Page.tsx
│   └── Edit<Module>Page.tsx
│
└── index.ts
```

### Hooks

```text
hooks/admin/
├── use<Module>.ts
├── use<Modules>.ts
└── use<Module>Actions.ts
```

### Service

```text
services/admin/<module>-service.ts
```

### Routes

```text
app/admin/<module>/
├── page.tsx
├── new/
│   └── page.tsx
└── [id]/
    └── edit/
        └── page.tsx
```

A ideia é manter os módulos consistentes, simples e previsíveis.

## Princípio do frontend

O frontend deve permanecer responsável principalmente por:

* Interface
* Estado da interface
* Formulários
* Navegação
* Comunicação com a API

As regras de negócio devem ser tratadas pela API sempre que possível.

Isso mantém o frontend mais simples e evita duplicação das regras do sistema.

# SCDP API

API do Sistema Corporativo de Pausas.

Construída utilizando Ruby on Rails, a API é responsável pelas regras de negócio, autenticação, persistência dos dados e disponibilização dos endpoints consumidos pelo frontend.

## Stack

* Ruby
* Ruby on Rails
* PostgreSQL
* Redis
* RSpec
* JWT
* OAuth

## Estrutura

A aplicação segue a estrutura convencional do Rails:

```text
scdp-api/
├── app/
│   ├── controllers/
│   ├── models/
│   └── services/
│
├── config/
├── db/
├── spec/
├── Gemfile
└── ...
```

## Principais diretórios

### `app/models`

Contém os modelos e regras de validação do domínio.

Exemplos:

```text
User
Team
TeamMembership
PauseType
Pause
PauseQueue
```

### `app/controllers`

Contém os controllers responsáveis pelos endpoints HTTP.

Os endpoints administrativos ficam organizados em:

```text
app/controllers/admin/
```

Exemplo:

```text
admin/
├── users_controller.rb
├── teams_controller.rb
├── team_memberships_controller.rb
└── pause_types_controller.rb
```

### `app/services`

Contém serviços utilizados para concentrar operações e regras de negócio que não devem ficar diretamente nos controllers.

Exemplos de serviços relacionados às pausas:

```text
StartPauseService
FinishPauseService
QueuePauseService
```

### `app/services/admin`

Contém presenters utilizados para definir o formato das respostas administrativas.

Exemplo:

```text
admin/
├── user_presenter.rb
├── team_presenter.rb
├── team_membership_presenter.rb
└── pause_type_presenter.rb
```

## Banco de dados

O projeto utiliza PostgreSQL.

As configurações de banco ficam nas configurações padrão do Rails.

Para criar o banco:

```bash
bin/rails db:create
```

Executar migrations:

```bash
bin/rails db:migrate
```

Caso seja necessário recriar o banco:

```bash
bin/rails db:drop db:create db:migrate
```

## Executando a API

Entre no projeto:

```bash
cd ~/Desenvolvimento/scdp/scdp-api
```

Verifique o Ruby ativo:

```bash
ruby -v
```

O projeto utiliza o ambiente Ruby configurado para o SCDP.

Para iniciar o servidor:

```bash
bin/rails server
```

A API ficará disponível no endereço padrão do Rails:

```text
http://localhost:3000
```

## Autenticação

A API utiliza JWT para autenticação das requisições.

O token é gerado através do:

```text
Auth::JwtService
```

As requisições autenticadas utilizam:

```http
Authorization: Bearer <token>
```

Os endpoints administrativos possuem autorização baseada no papel do usuário.

Os papéis existentes são:

```text
super_admin
admin
supervisor
agent
```

## OAuth

O projeto possui integração com autenticação OAuth.

O fluxo de autenticação permite que um usuário externo seja identificado e posteriormente associado a uma eventual inscrição existente por e-mail.

Um caso importante é o gerenciamento de membros de equipes.

Um administrador pode cadastrar:

```text
email@example.com
```

antes que exista um `User` correspondente.

Quando a pessoa realiza o login, a associação pode ser vinculada ao usuário.

## Endpoints administrativos

Os principais recursos administrativos possuem endpoints REST:

```text
GET    /admin/users
GET    /admin/users/:id
POST   /admin/users
PATCH  /admin/users/:id
DELETE /admin/users/:id

GET    /admin/teams
GET    /admin/teams/:id
POST   /admin/teams
PATCH  /admin/teams/:id
DELETE /admin/teams/:id

GET    /admin/team_memberships
GET    /admin/team_memberships/:id
POST   /admin/team_memberships
PATCH  /admin/team_memberships/:id
DELETE /admin/team_memberships/:id

GET    /admin/pause_types
GET    /admin/pause_types/:id
POST   /admin/pause_types
PATCH  /admin/pause_types/:id
DELETE /admin/pause_types/:id
```

## Tipos de pausa

Um `PauseType` pertence a uma equipe e possui configurações relacionadas ao controle das pausas.

Principais campos:

```text
name
team_id
has_time_limit
max_duration_minutes
max_concurrent
requires_queue
active
```

Quando:

```text
has_time_limit = true
```

`max_duration_minutes` deve estar preenchido.

Quando:

```text
has_time_limit = false
```

não é necessário definir uma duração máxima.

## Filas de pausa

Um tipo de pausa pode utilizar fila através de:

```text
requires_queue
```

Quando o limite de pausas simultâneas é atingido:

* se `requires_queue` estiver habilitado, o usuário pode entrar na fila;
* caso contrário, a operação é rejeitada.

## Testes

O projeto utiliza RSpec.

Executar toda a suíte:

```bash
bundle exec rspec
```

Executar uma especificação específica:

```bash
bundle exec rspec spec/requests/admin/pause_types_spec.rb
```

Também é possível executar especificações individuais:

```bash
bundle exec rspec spec/models
bundle exec rspec spec/services
bundle exec rspec spec/requests
```

## Estado atual dos testes

A suíte foi estruturada para testar:

* Models
* Services
* Requests
* Regras de negócio
* Autenticação dos endpoints administrativos

Antes de realizar alterações importantes, executar:

```bash
bundle exec rspec
```

## Desenvolvimento

Durante o desenvolvimento, o fluxo recomendado é:

```text
Alteração
   ↓
Model / Service / Controller
   ↓
RSpec
   ↓
Endpoint
   ↓
Frontend
```

As regras de negócio devem permanecer preferencialmente na camada de domínio/service, evitando controllers excessivamente complexos.

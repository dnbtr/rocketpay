# Rocketpay

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
  * [Elixir docs](https://elixir-lang.org/getting-started/basic-types.html)

### Anotações de aula (tudo caótico por hora)

Documentação
[Hex Docs](https://hexdocs.pm/)

Iniciando projeto
`$ mix phx.new rocketpay --no-webpack --no-html`

`$ mix ecto.setup` - Conecta com DB e realiza migrations
`$ mix ecto.create` - Cria banco de dados
`$ mix ecto.gen.migration [NOME-TABELA]` - Criar migration
`$ mix ecto.migrate` - Rodar migrations
`$ mix ecto.drop` - Dropa o schema? O banco inteiro?

mix.exs - Inserir Credo como dependência
  - `{:credo, "~> 1.5", only: [:dev, :test], runtime: false}`

`$ mix credo gen.config`
  - {Credo.Check.Readability.ModuleDoc, []}, Para `false`;
    - Para não gerar documentação automática

Iniciar o servidor
`mix phx.server`
  - Ir para localhost:4000/dashboard
    - Dashboard de monitoramento atualiza automaticamente

Definir rota no **router.ex** e criar Controller

Testando funções (IEX)
`$ iex -S mix` para ter acesso às funções definidas no projeto
`iex(1)> Rocketpay.Numbers.sum_from_file("numbers")`
devolve a tupla `{:ok, 1,2,3,4,8,9,10}` ou `{:error, :enoent}` se arquivo não existir
`iex(1)> h [NOME - FUNÇÃO` traz a documentação (como o "man" do bash)

**Pattern matching**

> [1,2,3,4]
> [a,b,c,d] = [1,2,3,4] 
> [a,b] = [1,2,3,4] <!-- Dá erro -->

Ver também função sum_from_file para ver mais pattern matching

**Pipe operator**
Primeiro argumento é implícito e não precisa ser declarado ao chamar a função

**Retorno de função**
É implícito também. Colocar apenas o nome da variável no fim da função

**IO.inspect(), IO.puts()**
É semelhante ao console.log()

**Enum x Stream**
Stream é um lazy operator, só é executado quando o resultado é necessário
É possível concatenar várias operações e depois concatenar em um Enum

**Schemas**
Ao contrário de Models, tem apenas mapeamento de dados, não tem nenhum comportamento

Adicionar essa config no ./config/config.exs para setar UUID como chaves do banco
```elixir
config :rocketpay, Rocketpay.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id],
```
**Changeset**
Recebe params, faz o cast e mapeia para os tipos da tabela
Repo lida automaticamente com retorno do Changeset (insere no banco ou mostra erros de validação )

- Exemplo de changeset de Update (que não começa com struct vazia)
```elixir
def changeset(struct \\ %__MODULE__{}, params) do
  struct
  |> cast(params, @required_params)
  |> validate_required(@required_params)
  |> check_constraint(:balance, name: :balance_must_be_positive_or_zero)
end
```
- Exemplo de changeset de criação de usuário (parte de struct vazia)
```elixir
  def changeset(params) do
    # cria struct vazia, insere dados e valida
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:nickname])
    |> put_password_hash()
  end
```

**Tratativa de erro**
Foi melhorada (para casos de bad request)
Ver error_view e função *translate_errors* (tirada do próprio site do Phoenix)

**Fallback Controller**
É o controller que tenta lidar com qualquer erro não tratado

Testando
`$ iex -S mix`
`> Rocketpay.User.changeset(%{name: "teste", password: "123123", email: "email@email.com", nickname: "teste", age: 99})`

  - Definindo parâmetros
    `> params = %{name: "teste", password: "123123", email: "email@email.com", nickname: "teste", age: 99}`

  - Inserindo no banco
    `> params |> User.changeset() |> Rocketpay.Repo.insert(changeset)`

**Fachada (Facade?)**
Criado no rocketpay.ex, para chamar Rocketpay.create_user diretamente (ao invés de Rocketpay.Users.Create)
  - Definindo parâmetros
    `> params = %{name: "teste", password: "123123", email: "email@email.com", nickname: "teste", age: 99}`
  - Gravando no banco
    `> Rocketpay.create_user(params)`

**With**
Ideal para ser usado em controllers, já que não é preciso programar rotas para tratar erro
  - Qualquer erro é devolvido para a função que chama, e então é tratado pelo Fallback controller

**Relacionamento entre tabelas**
Depois de criada a tabela de accounts:
`> params = ${user_id: "[ID AQUI]", balance: "0.00"}`
`> Rocketpay.Account.changeset() |> Rocketpay.Repo.insert()`
Para carregar a conta que foi criada em um usuário
`> Rocketpay.Repo.all(Rocketpay.User) |> Rocketpay.Repo.preload(:account)`

**Ecto.Multi**
Para fazer transações multiplas no banco (no caso, para criar conta de usuário + account)
Ver arquivo *create.ex*

### Benchmarking

The first GET request:
```
[debug] Processing with RocketpayWeb.WelcomeController.index/2
  Parameters: %{}
  Pipelines: [:api]
[info] Sent 200 in 963µs
[info] GET /api
```
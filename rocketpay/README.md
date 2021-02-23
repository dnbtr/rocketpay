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

### Comandos

Iniciando projeto
`$ mix phx.new rocketpay --no-webpack --no-html`

`$ mix ecto.setup`
  - Conecta com DB e realiza migrations

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

### Benchmarking

The first GET request:
```
[debug] Processing with RocketpayWeb.WelcomeController.index/2
  Parameters: %{}
  Pipelines: [:api]
[info] Sent 200 in 963µs
[info] GET /api
```
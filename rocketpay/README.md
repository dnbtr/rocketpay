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

### Benchmarking

The first GET request:
```
[debug] Processing with RocketpayWeb.WelcomeController.index/2
  Parameters: %{}
  Pipelines: [:api]
[info] Sent 200 in 963µs
[info] GET /api
```
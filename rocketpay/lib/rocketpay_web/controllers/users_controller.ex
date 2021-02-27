defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  alias Rocketpay.User

  # Definindo o controller de fallback
  action_fallback RocketpayWeb.FallbackController

  # Se Rocketpay.create_user(params) dá erro,
  # é retornado erro para função que chamou a create,
  # e então cai no fallback controller

  def create(conn, params) do
    with {:ok, %User{} = user} <- Rocketpay.create_user(params) do
      # Poderia ter outros casos de validação aqui
      # se der erro em qualquer uma, devolve o erro para quem chamou
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end

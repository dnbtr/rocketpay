defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller

  alias Rocketpay.User

  action_fallback RocketpayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = user} <- Rocketpay.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("create.json", account: account)
  end

  def withdraw(conn, params) do

  end

end

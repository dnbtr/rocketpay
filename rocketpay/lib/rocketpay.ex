defmodule Rocketpay do
  # Fachada (??) - Pesquisar sobre o conceito
  alias Rocketpay.Users.Create, as: UserCreate

  defdelegate create_user(params), to: UserCreate, as: :call
end

defmodule Rocketpay.User do
  use Ecto.Schema
  import Ecto.Changeset

  # Cria um alias para não digitar Ecto.Changeset no put_password_hash
  alias Ecto.Changeset

  # binary_id = UUID
  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :age, :email, :password, :nickname]

  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :nickname, :string

    timestamps()
  end

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

  # recebe struct do tipo changeset
  # Se changeset valido, le o map(strict) changes e pega o password e atribui a variável changest
  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  # Se inválido, apenas devolve o changeset
  defp put_password_hash(changeset), do: changeset
end

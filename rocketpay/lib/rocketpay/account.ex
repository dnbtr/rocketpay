defmodule Rocketpay.Account do
  use Ecto.Schema
  import Ecto.Changeset

  # Cria um alias para não digitar Ecto.Changeset no put_password_hash
  alias Ecto.Changeset
  alias Rocketpay.User

  # binary_id = UUID
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:balance, :user_id]

  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User

    timestamps()
  end

  # Changeset de update não começa com struct vazia
  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> check_constraint(:balance, name: :balance_must_be_positive_or_zero)
  end
end

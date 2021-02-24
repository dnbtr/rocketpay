defmodule Rocketpay.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  # def up e def down também pode ser usado
  def change do
    create table :users do
      # ID é implícito e gerado automaticamente pelo Ecto
      add :name, :string
      add :age, :integer
      add :email, :string
      add :password_hash, :string
      add :nickname, :string

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:nickname])
  end
end

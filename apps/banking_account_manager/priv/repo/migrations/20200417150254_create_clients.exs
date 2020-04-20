defmodule BankingAccountManager.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :encrypted_name, :binary
      add :encrypted_email, :binary
      add :encrypted_cpf, :binary
      add :encrypted_birth_date, :binary
      add :gender, :string
      add :city, :string
      add :state, :string
      add :country, :string
      add :referral_code, :string

      timestamps()
    end

    create unique_index(:clients, [:encrypted_email])
    create unique_index(:clients, [:encrypted_cpf])
  end
end

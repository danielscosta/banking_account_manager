defmodule BankingAccountManager.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :encrypted_name, :string
      add :encrypted_email, :string
      add :encrypted_cpf, :string
      add :encrypted_birth_date, :string
      add :gender, :string
      add :city, :string
      add :state, :string
      add :country, :string
      add :referral_code, :string

      timestamps()
    end

  end
end

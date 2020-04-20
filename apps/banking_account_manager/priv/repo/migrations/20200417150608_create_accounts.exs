defmodule BankingAccountManager.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :status, :string
      add :referral_code, :string
      add :client_id, references(:clients, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:accounts, [:client_id])
    create unique_index(:accounts, [:referral_code])
  end
end

defmodule BankingAccountManager.Repo do
  use Ecto.Repo,
    otp_app: :banking_account_manager,
    adapter: Ecto.Adapters.Postgres
end

import Config

config :banking_account_manager,
  encryption_key: System.get_env("ENCRYPTION_KEY")

config :banking_account_manager, BankingAccountManager.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

config :banking_account_manager_web, BankingAccountManagerWeb.Endpoint,
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
  server: true

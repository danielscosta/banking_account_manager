# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Configure Mix tasks and generators
config :banking_account_manager,
  ecto_repos: [BankingAccountManager.Repo],
  encryption_key: "+fmYuFICS1a5ZVxesmRrpQ=="

config :banking_account_manager_web,
  ecto_repos: [BankingAccountManager.Repo],
  generators: [context_app: :banking_account_manager, binary_id: true]

# Configures the endpoint
config :banking_account_manager_web, BankingAccountManagerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NIvEi8pNOE8zixNVfPW4FLdL9Sr8Ck49cZatElXel1949uo1o9VKSQmn4TxrLJcv",
  render_errors: [view: BankingAccountManagerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: BankingAccountManagerWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

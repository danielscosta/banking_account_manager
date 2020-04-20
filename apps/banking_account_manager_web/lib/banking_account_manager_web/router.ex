defmodule BankingAccountManagerWeb.Router do
  use BankingAccountManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BankingAccountManagerWeb do
    pipe_through :api

    resources "/accounts", AccountController, only: [:show, :delete]
    put "/accounts", AccountController, :upsert
    get "/accounts/:id/relatedAccounts", AccountController, :related_accounts
  end
end

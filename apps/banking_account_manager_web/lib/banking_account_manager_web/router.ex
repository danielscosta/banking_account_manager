defmodule BankingAccountManagerWeb.Router do
  use BankingAccountManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BankingAccountManagerWeb do
    pipe_through :api
  end
end

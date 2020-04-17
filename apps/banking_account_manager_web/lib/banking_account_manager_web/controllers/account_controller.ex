defmodule BankingAccountManagerWeb.AccountController do
  use BankingAccountManagerWeb, :controller

  alias BankingAccountManager.BancaryRegistries
  alias BankingAccountManager.BancaryRegistries.Account

  action_fallback BankingAccountManagerWeb.FallbackController

  def index(conn, _params) do
    accounts = BancaryRegistries.list_accounts()
    render(conn, "index.json", accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- BancaryRegistries.create_account(account_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.account_path(conn, :show, account))
      |> render("show.json", account: account)
    end
  end

  def show(conn, %{"id" => id}) do
    account = BancaryRegistries.get_account!(id)
    render(conn, "show.json", account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = BancaryRegistries.get_account!(id)

    with {:ok, %Account{} = account} <- BancaryRegistries.update_account(account, account_params) do
      render(conn, "show.json", account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = BancaryRegistries.get_account!(id)

    with {:ok, %Account{}} <- BancaryRegistries.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end

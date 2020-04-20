defmodule BankingAccountManagerWeb.AccountController do
  use BankingAccountManagerWeb, :controller

  alias BankingAccountManager.BancaryRegistries
  alias BankingAccountManager.BancaryRegistries.Account

  action_fallback BankingAccountManagerWeb.FallbackController

  def upsert(conn, %{"account" => account_params}) do
    with {:ok, %{account: %Account{} = account}} <-
           BancaryRegistries.upsert_account(account_params) do
      conn
      |> put_status(:ok)
      |> put_resp_header("location", Routes.account_path(conn, :show, account))
      |> render("show.json", account: account)
    end
  end

  def show(conn, %{"id" => id}) do
    account = BancaryRegistries.get_account!(id)
    render(conn, "show.json", account: account)
  end

  def delete(conn, %{"id" => id}) do
    account = BancaryRegistries.get_account!(id)

    with {:ok, %Account{}} <- BancaryRegistries.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end

  def related_accounts(conn, %{"id" => id}) do
    with {:ok, related_accounts} <- BancaryRegistries.get_related_accounts!(id) do
      render(conn, "index.json", related_accounts: related_accounts)
    end
  end
end

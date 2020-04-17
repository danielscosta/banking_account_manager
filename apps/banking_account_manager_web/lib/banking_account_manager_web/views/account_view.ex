defmodule BankingAccountManagerWeb.AccountView do
  use BankingAccountManagerWeb, :view
  alias BankingAccountManagerWeb.AccountView

  def render("index.json", %{accounts: accounts}) do
    %{data: render_many(accounts, AccountView, "account.json")}
  end

  def render("show.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account.json")}
  end

  def render("account.json", %{account: account}) do
    %{id: account.id,
      status: account.status,
      referral_code: account.referral_code}
  end
end

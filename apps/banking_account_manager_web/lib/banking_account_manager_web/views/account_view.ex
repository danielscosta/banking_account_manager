defmodule BankingAccountManagerWeb.AccountView do
  use BankingAccountManagerWeb, :view
  alias BankingAccountManagerWeb.AccountView

  def render("index.json", %{related_accounts: related_accounts}) do
    %{data: render_many(related_accounts, AccountView, "related_account.json")}
  end

  def render("show.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account.json")}
  end

  def render("account.json", %{account: account}) do
    %{id: account.id, status: account.status, referral_code: account.referral_code}
  end

  def render("related_account.json", %{account: %{id: id, name: name}}) do
    %{id: id, name: name}
  end
end

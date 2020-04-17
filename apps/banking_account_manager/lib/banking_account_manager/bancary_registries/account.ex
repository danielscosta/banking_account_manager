defmodule BankingAccountManager.BancaryRegistries.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :referral_code, :string
    field :status, :string
    field :client_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:status, :referral_code])
    |> validate_required([:status, :referral_code])
  end
end

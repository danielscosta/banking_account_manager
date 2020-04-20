defmodule BankingAccountManager.BancaryRegistries.Account do
  @moduledoc """
  The Account schema is data representation of account from a client.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias BankingAccountManager.BancaryRegistries.Client

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :referral_code, :string
    field :status, :string, default: "draft"
    belongs_to :client, Client

    timestamps()
  end

  @statuses ~w(draft complete)

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:status, :client_id])
    |> validate_required([:client_id])
    |> validate_inclusion(:status, @statuses)
    |> generate_referral_code
    |> validate_length(:referral_code, is: 8)
    |> unique_constraint(:referral_code)
  end

  defp generate_referral_code(%{changes: %{status: "complete"}} = changeset),
    do:
      put_change(
        changeset,
        :referral_code,
        10_000_000..99_999_999 |> Enum.random() |> Integer.to_string()
      )

  defp generate_referral_code(changeset), do: changeset
end

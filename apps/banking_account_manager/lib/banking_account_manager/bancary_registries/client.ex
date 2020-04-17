defmodule BankingAccountManager.BancaryRegistries.Client do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "clients" do
    field :city, :string
    field :country, :string
    field :encrypted_birth_date, :string
    field :encrypted_cpf, :string
    field :encrypted_email, :string
    field :encrypted_name, :string
    field :gender, :string
    field :referral_code, :string
    field :state, :string

    timestamps()
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:encrypted_name, :encrypted_email, :encrypted_cpf, :encrypted_birth_date, :gender, :city, :state, :country, :referral_code])
    |> validate_required([:encrypted_name, :encrypted_email, :encrypted_cpf, :encrypted_birth_date, :gender, :city, :state, :country, :referral_code])
  end
end

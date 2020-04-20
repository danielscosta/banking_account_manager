defmodule BankingAccountManager.BancaryRegistries.Client do
  @moduledoc """
  The Client schema stores referred data from a possible client.
  """

  use Ecto.Schema
  import Ecto.Changeset

  import Brcpfcnpj.Changeset

  alias BankingAccountManager.Encryption

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "clients" do
    field :birth_date, :date, virtual: true
    field :city, :string
    field :country, :string
    field :cpf, :string, virtual: true
    field :email, :string, virtual: true
    field :encrypted_birth_date, :binary
    field :encrypted_cpf, :binary
    field :encrypted_email, :binary
    field :encrypted_name, :binary
    field :gender, :string
    field :name, :string, virtual: true
    field :referral_code, :string
    field :state, :string

    timestamps()
  end

  @optional ~w(birth_date city country cpf email gender name referral_code state)a
  @required ~w(cpf)a

  @country ~w(brazil)
  @states ~w(ac al ap am ce df es go ma mt ms mg pa pb pr pe pr pi rj rn rs ro rr sc sp se to)
  @genders ~w(male female other)

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> validate_cpf(:cpf)
    |> validate_format(:email, ~r/@/)
    |> downcase_city
    |> downcase_coutry
    |> downcase_email
    |> downcase_gender
    |> downcase_name
    |> downcase_state
    |> validate_inclusion(:country, @country, message: "The only country accepted is Brazil")
    |> validate_inclusion(:gender, @genders,
      message: "The accepted values are the genders male, female and other"
    )
    |> validate_length(:referral_code, is: 8)
    |> validate_inclusion(:state, @states,
      message: "You should put one abbreviation of Brazil states"
    )
    |> encrypt_birth_date
    |> encrypt_cpf
    |> encrypt_email
    |> encrypt_name
    |> unique_constraint(:encrypt_cpf)
    |> unique_constraint(:encrypt_email)
  end

  defp downcase_city(%{changes: %{city: city}} = changeset) when not is_nil(city),
    do: update_change(changeset, :city, &String.downcase/1)

  defp downcase_city(changeset), do: changeset

  defp downcase_coutry(%{changes: %{country: country}} = changeset) when not is_nil(country),
    do: update_change(changeset, :country, &String.downcase/1)

  defp downcase_coutry(changeset), do: changeset

  defp downcase_email(%{changes: %{email: email}} = changeset) when not is_nil(email),
    do: update_change(changeset, :email, &String.downcase/1)

  defp downcase_email(changeset), do: changeset

  defp downcase_gender(%{changes: %{gender: gender}} = changeset) when not is_nil(gender),
    do: update_change(changeset, :gender, &String.downcase/1)

  defp downcase_gender(changeset), do: changeset

  defp downcase_name(%{changes: %{name: name}} = changeset) when not is_nil(name),
    do: update_change(changeset, :name, &String.downcase/1)

  defp downcase_name(changeset), do: changeset

  defp downcase_state(%{changes: %{state: state}} = changeset) when not is_nil(state),
    do: update_change(changeset, :state, &String.downcase/1)

  defp downcase_state(changeset), do: changeset

  defp encrypt_birth_date(%{changes: %{birth_date: birth_date}} = changeset)
       when not is_nil(birth_date),
       do:
         put_change(
           changeset,
           :encrypted_birth_date,
           Encryption.encrypt(Date.to_string(birth_date))
         )

  defp encrypt_birth_date(changeset), do: changeset

  defp encrypt_cpf(%{changes: %{cpf: cpf}} = changeset) when not is_nil(cpf),
    do: put_change(changeset, :encrypted_cpf, Encryption.encrypt(cpf))

  defp encrypt_cpf(changeset), do: changeset

  defp encrypt_email(%{changes: %{email: email}} = changeset) when not is_nil(email),
    do: put_change(changeset, :encrypted_email, Encryption.encrypt(email))

  defp encrypt_email(changeset), do: changeset

  defp encrypt_name(%{changes: %{name: name}} = changeset) when not is_nil(name),
    do: put_change(changeset, :encrypted_name, Encryption.encrypt(name))

  defp encrypt_name(changeset), do: changeset
end

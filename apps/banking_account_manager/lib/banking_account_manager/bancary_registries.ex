defmodule BankingAccountManager.BancaryRegistries do
  @moduledoc """
  The BancaryRegistries context.
  """

  import Ecto.Query, warn: false
  alias BankingAccountManager.Repo

  alias BankingAccountManager.Encryption

  alias BankingAccountManager.BancaryRegistries.Account
  alias BankingAccountManager.BancaryRegistries.Client
  alias Ecto.Multi

  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account!(id), do: Repo.get!(Account, id)

  @doc """
  Create or Update a account.

  ## Examples

      iex> upsert_account(%{field: value})
      {:ok, %{client: %Client{}, account: %Account{}}}

      iex> upsert_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def upsert_account(attrs \\ %{}) do
    Multi.new()
    |> Multi.run(:client, fn _repo, _changes ->
      client = get_client_by_cpf(attrs["cpf"] || attrs[:cpf]) || %Client{}

      client
      |> Client.changeset(attrs)
      |> Repo.insert_or_update()
    end)
    |> Multi.run(:account, fn _repo, %{client: client} = _changes ->
      is_complete? =
        client
        |> Map.from_struct()
        |> Map.keys()
        |> Enum.reduce(true, fn key, acc ->
          acc and not is_nil(Map.get(client, key))
        end)

      status =
        if is_complete? do
          "complete"
        else
          "draft"
        end

      account = Repo.get_by(Account, client_id: client.id) || %Account{}

      account
      |> Account.changeset(%{client_id: client.id, status: status})
      |> Repo.insert_or_update()
    end)
    |> Repo.transaction()
  end

  defp get_client_by_cpf(nil), do: nil

  defp get_client_by_cpf(cpf), do: Repo.get_by(Client, encrypted_cpf: Encryption.hash(cpf))

  @doc """
  Deletes a account.

  ## Examples

      iex> delete_account(account)
      {:ok, %Account{}}

      iex> delete_account(account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account(%Account{} = account) do
    Repo.delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{source: %Account{}}

  """
  def change_account(%Account{} = account) do
    Account.changeset(account, %{})
  end
end

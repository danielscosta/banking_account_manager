defmodule BankingAccountManager.BancaryRegistriesTest do
  use BankingAccountManager.DataCase

  alias BankingAccountManager.BancaryRegistries

  describe "clients" do
    alias BankingAccountManager.BancaryRegistries.Client

    @valid_attrs %{city: "some city", country: "some country", encrypted_birth_date: "some encrypted_birth_date", encrypted_cpf: "some encrypted_cpf", encrypted_email: "some encrypted_email", encrypted_name: "some encrypted_name", gender: "some gender", referral_code: "some referral_code", state: "some state"}
    @update_attrs %{city: "some updated city", country: "some updated country", encrypted_birth_date: "some updated encrypted_birth_date", encrypted_cpf: "some updated encrypted_cpf", encrypted_email: "some updated encrypted_email", encrypted_name: "some updated encrypted_name", gender: "some updated gender", referral_code: "some updated referral_code", state: "some updated state"}
    @invalid_attrs %{city: nil, country: nil, encrypted_birth_date: nil, encrypted_cpf: nil, encrypted_email: nil, encrypted_name: nil, gender: nil, referral_code: nil, state: nil}

    def client_fixture(attrs \\ %{}) do
      {:ok, client} =
        attrs
        |> Enum.into(@valid_attrs)
        |> BancaryRegistries.create_client()

      client
    end

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert BancaryRegistries.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert BancaryRegistries.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      assert {:ok, %Client{} = client} = BancaryRegistries.create_client(@valid_attrs)
      assert client.city == "some city"
      assert client.country == "some country"
      assert client.encrypted_birth_date == "some encrypted_birth_date"
      assert client.encrypted_cpf == "some encrypted_cpf"
      assert client.encrypted_email == "some encrypted_email"
      assert client.encrypted_name == "some encrypted_name"
      assert client.gender == "some gender"
      assert client.referral_code == "some referral_code"
      assert client.state == "some state"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BancaryRegistries.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      assert {:ok, %Client{} = client} = BancaryRegistries.update_client(client, @update_attrs)
      assert client.city == "some updated city"
      assert client.country == "some updated country"
      assert client.encrypted_birth_date == "some updated encrypted_birth_date"
      assert client.encrypted_cpf == "some updated encrypted_cpf"
      assert client.encrypted_email == "some updated encrypted_email"
      assert client.encrypted_name == "some updated encrypted_name"
      assert client.gender == "some updated gender"
      assert client.referral_code == "some updated referral_code"
      assert client.state == "some updated state"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = BancaryRegistries.update_client(client, @invalid_attrs)
      assert client == BancaryRegistries.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = BancaryRegistries.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> BancaryRegistries.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = BancaryRegistries.change_client(client)
    end
  end

  describe "accounts" do
    alias BankingAccountManager.BancaryRegistries.Account

    @valid_attrs %{referral_code: "some referral_code", status: "some status"}
    @update_attrs %{referral_code: "some updated referral_code", status: "some updated status"}
    @invalid_attrs %{referral_code: nil, status: nil}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> BancaryRegistries.create_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert BancaryRegistries.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert BancaryRegistries.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      assert {:ok, %Account{} = account} = BancaryRegistries.create_account(@valid_attrs)
      assert account.referral_code == "some referral_code"
      assert account.status == "some status"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BancaryRegistries.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      assert {:ok, %Account{} = account} = BancaryRegistries.update_account(account, @update_attrs)
      assert account.referral_code == "some updated referral_code"
      assert account.status == "some updated status"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = BancaryRegistries.update_account(account, @invalid_attrs)
      assert account == BancaryRegistries.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = BancaryRegistries.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> BancaryRegistries.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = BancaryRegistries.change_account(account)
    end
  end
end

defmodule BankingAccountManager.BancaryRegistriesTest do
  use BankingAccountManager.DataCase

  alias BankingAccountManager.BancaryRegistries

  describe "accounts" do
    alias BankingAccountManager.BancaryRegistries.Account

    @cpf Brcpfcnpj.cpf_generate()
    @parcial_valid_attrs %{cpf: @cpf}
    @complete_valid_attrs %{
      cpf: @cpf,
      birth_date: ~D[2020-04-20],
      city: "Curitiba",
      country: "Brazil",
      email: Faker.Internet.email(),
      gender: "Male",
      name: Faker.Name.name(),
      referral_code: Faker.Util.format("%8d"),
      state: "PR"
    }
    @invalid_attrs %{cpf: nil}

    def account_fixture(attrs \\ %{}) do
      {:ok, %{account: account}} =
        attrs
        |> Enum.into(@parcial_valid_attrs)
        |> BancaryRegistries.upsert_account()

      account
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert BancaryRegistries.get_account!(account.id) == account
    end

    test "upsert_account/1 with valid data(incomplete) creates a account" do
      assert {:ok, %{account: %Account{} = account}} =
               BancaryRegistries.upsert_account(@parcial_valid_attrs)

      assert account.status == "draft"
      assert is_nil(account.referral_code)
    end

    test "update_account/2 with invalid data returns error changeset" do
      assert {:error, :client, %Ecto.Changeset{}, %{}} =
               BancaryRegistries.upsert_account(@invalid_attrs)
    end

    test "upsert_account/1 with valid data(complete) creates a account" do
      assert {:ok, %{account: %Account{} = account}} =
               BancaryRegistries.upsert_account(@complete_valid_attrs)

      assert account.status == "complete"
      assert not is_nil(account.referral_code)
    end

    test "upsert_account/1 with valid data(incomplete) creates a account and after updates with valid data(complete)" do
      assert {:ok, %{account: %Account{} = account}} =
               BancaryRegistries.upsert_account(@parcial_valid_attrs)

      assert account.status == "draft"
      assert is_nil(account.referral_code)

      assert {:ok, %{account: %Account{} = account}} =
               BancaryRegistries.upsert_account(@complete_valid_attrs)

      assert account.status == "complete"
      assert not is_nil(account.referral_code)
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

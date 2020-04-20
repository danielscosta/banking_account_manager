defmodule BankingAccountManagerWeb.AccountControllerTest do
  use BankingAccountManagerWeb.ConnCase

  alias BankingAccountManager.BancaryRegistries
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

  def fixture(:account) do
    {:ok, %{account: %Account{} = account}} =
      BancaryRegistries.upsert_account(@parcial_valid_attrs)

    account
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create account" do
    test "renders account when data(incomplete) is valid", %{conn: conn} do
      conn = put(conn, Routes.account_path(conn, :upsert), account: @parcial_valid_attrs)
      assert %{"id" => id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.account_path(conn, :show, id))

      assert %{
               "id" => id,
               "referral_code" => referral_code,
               "status" => "draft"
             } = json_response(conn, 200)["data"]

      assert is_nil(referral_code)
    end

    test "renders account when data(complete) is valid", %{conn: conn} do
      conn = put(conn, Routes.account_path(conn, :upsert), account: @complete_valid_attrs)
      assert %{"id" => id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.account_path(conn, :show, id))

      assert %{
               "id" => id,
               "referral_code" => referral_code,
               "status" => "complete"
             } = json_response(conn, 200)["data"]

      assert not is_nil(referral_code)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = put(conn, Routes.account_path(conn, :upsert), account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete account" do
    setup [:create_account]

    test "deletes chosen account", %{conn: conn, account: account} do
      conn = delete(conn, Routes.account_path(conn, :delete, account))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.account_path(conn, :show, account))
      end
    end
  end

  defp create_account(_) do
    account = fixture(:account)
    {:ok, account: account}
  end
end

# credo:disable-for-this-file
defmodule BankingAccountManagerWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use BankingAccountManagerWeb.ConnCase, async: true`, although
  this option is not recommendded for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      alias BankingAccountManagerWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint BankingAccountManagerWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(BankingAccountManager.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(BankingAccountManager.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end

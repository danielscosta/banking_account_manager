defmodule BankingAccountManagerWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use BankingAccountManagerWeb, :controller

  def call(conn, {:error, :client, %Ecto.Changeset{} = changeset, %{}}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BankingAccountManagerWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, message: message}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BankingAccountManagerWeb.ErrorView)
    |> render("error_message.json", message: message)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(BankingAccountManagerWeb.ErrorView)
    |> render(:"404")
  end
end

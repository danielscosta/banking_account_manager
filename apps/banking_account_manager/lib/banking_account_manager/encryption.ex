defmodule BankingAccountManager.Encryption do
  @moduledoc """
   This module encrypt and validate data.
  """
  alias Bcrypt

  def hash(data), do: Bcrypt.hash_pwd_salt(data)

  def validate(encrypted_data, data),
    do: Bcrypt.verify_pass(data, encrypted_data)
end

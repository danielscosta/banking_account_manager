defmodule BankingAccountManager.Encryption do
  @moduledoc """
   This module encrypt and validate data by https://www.thegreatcodeadventure.com/elixir-encryption-with-erlang-crypto/.
  """
  @aad "AES256GCM"

  def encrypt(val) do
    key = Application.get_env(:banking_account_manager, :encryption_key)
    mode = :aes_gcm
    secret_key = :base64.decode(key)
    iv = :crypto.strong_rand_bytes(16)

    {ciphertext, ciphertag} =
      :crypto.block_encrypt(mode, secret_key, iv, {@aad, to_string(val), 16})

    iv <> ciphertag <> ciphertext
  end

  def decrypt(ciphertext) do
    key = Application.get_env(:banking_account_manager, :encryption_key)
    mode = :aes_gcm
    secret_key = :base64.decode(key)
    <<iv::binary-16, tag::binary-16, ciphertext::binary>> = ciphertext
    :crypto.block_decrypt(mode, secret_key, iv, {@aad, ciphertext, tag})
  end
end

defmodule Betachef.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Betachef.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        date_of_birth: "some date_of_birth",
        email: "some email",
        first_name: "some first_name",
        full_name: "some first_name" <> " " <> "some last_name",
        home_town: "some home_town",
        last_name: "some last_name",
        nationality: "some nationality",
        phone_number: "some phone_number",
        residential_address: "some residential_address",
        state_of_origin: "some state_of_origin",
        password: "1234",
        password_confirmation: "1234"
      })
      |> Betachef.Accounts.create_user()

    user
  end

  @doc """
  Generate a payment.
  """

  def paystack_api_caller do
    HTTPoison.get!("http://api.paystack.com/&appid=#{System.get_env("PAYSTACK_KEY")}")
  end

  def payment_fixture(attrs \\ %{}) do
    user = user_fixture()

    {:ok, payment} =
      attrs
      |> Enum.into(%{
        mode: "some mode",
        user_id: user.id
      })
      |> Betachef.Accounts.create_payment()

    payment
  end
end

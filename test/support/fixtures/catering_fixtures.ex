defmodule Betachef.CateringFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Betachef.Catering` context.
  """

  import Betachef.AccountsFixtures

  @doc """
  Generate a caterer.
  """
  def caterer_fixture(attrs \\ %{}) do
    {:ok, caterer} =
      attrs
      |> Enum.into(%{
        country: "some country",
        email: "some email",
        first_name: "some first_name",
        full_name: "some full_name",
        last_name: "some last_name",
        phone_number: "some phone_number"
      })
      |> Betachef.Catering.create_caterer()

    caterer
  end

  @doc """
  Generate a catering_service.
  """
  def catering_service_fixture(attrs \\ %{}) do
    caterer = caterer_fixture()

    {:ok, catering_service} =
      attrs
      |> Enum.into(%{
        available_days: "some available_days",
        business_email: "some business_email",
        business_name: "some business_name",
        business_phone_number: "some business_phone_number",
        description: "some description",
        image: "some image",
        price_per_number_of_guest: "some price_per_number_of_guest",
        specialization: "some specialization",
        working_hours: "some working_hours",
        caterer_id: caterer.id
      })
      |> Betachef.Catering.create_catering_service()

    catering_service
  end

  @spec booking_fixture(any) :: any
  @doc """
  Generate a booking.
  """
  def booking_fixture(attrs \\ %{}) do
    user = user_fixture()
    catering_service = catering_service_fixture()

    {:ok, booking} =
      attrs
      |> Enum.into(%{
        booking_state: "some booking_state",
        end_date: "some end_date",
        start_date: "some start_date",
        user_id: user.id,
        catering_service_id: catering_service.id
      })
      |> Betachef.Catering.create_booking()

    booking
  end
end

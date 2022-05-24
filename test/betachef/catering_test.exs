defmodule Betachef.CateringTest do
  use Betachef.DataCase

  alias Betachef.Catering

  describe "caterers" do
    alias Betachef.Catering.Caterer

    import Betachef.CateringFixtures

    @invalid_attrs %{
      country: nil,
      email: nil,
      first_name: nil,
      full_name: nil,
      last_name: nil,
      phone_number: nil
    }

    test "list_caterers/0 returns all caterers" do
      caterer = caterer_fixture()
      assert Catering.list_caterers() == [caterer]
    end

    test "get_caterer!/1 returns the caterer with given id" do
      caterer = caterer_fixture()
      assert Catering.get_caterer!(caterer.id) == caterer
    end

    test "create_caterer/1 with valid data creates a caterer" do
      valid_attrs = %{
        country: "some country",
        email: "some email",
        first_name: "some first_name",
        full_name: "some full_name",
        last_name: "some last_name",
        phone_number: "some phone_number"
      }

      assert {:ok, %Caterer{} = caterer} = Catering.create_caterer(valid_attrs)
      assert caterer.country == "some country"
      assert caterer.email == "some email"
      assert caterer.first_name == "some first_name"
      assert caterer.full_name == "some full_name"
      assert caterer.last_name == "some last_name"
      assert caterer.phone_number == "some phone_number"
    end

    test "create_caterer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catering.create_caterer(@invalid_attrs)
    end

    test "update_caterer/2 with valid data updates the caterer" do
      caterer = caterer_fixture()

      update_attrs = %{
        country: "some updated country",
        email: "some updated email",
        first_name: "some updated first_name",
        full_name: "some updated full_name",
        last_name: "some updated last_name",
        phone_number: "some updated phone_number"
      }

      assert {:ok, %Caterer{} = caterer} = Catering.update_caterer(caterer, update_attrs)
      assert caterer.country == "some updated country"
      assert caterer.email == "some updated email"
      assert caterer.first_name == "some updated first_name"
      assert caterer.full_name == "some updated full_name"
      assert caterer.last_name == "some updated last_name"
      assert caterer.phone_number == "some updated phone_number"
    end

    test "update_caterer/2 with invalid data returns error changeset" do
      caterer = caterer_fixture()
      assert {:error, %Ecto.Changeset{}} = Catering.update_caterer(caterer, @invalid_attrs)
      assert caterer == Catering.get_caterer!(caterer.id)
    end

    test "delete_caterer/1 deletes the caterer" do
      caterer = caterer_fixture()
      assert {:ok, %Caterer{}} = Catering.delete_caterer(caterer)
      assert_raise Ecto.NoResultsError, fn -> Catering.get_caterer!(caterer.id) end
    end

    test "change_caterer/1 returns a caterer changeset" do
      caterer = caterer_fixture()
      assert %Ecto.Changeset{} = Catering.change_caterer(caterer)
    end
  end

  describe "catering_services" do
    alias Betachef.Catering.CateringService

    import Betachef.CateringFixtures

    @invalid_attrs %{
      available_days: nil,
      business_email: nil,
      business_name: nil,
      business_phone_number: nil,
      description: nil,
      image: nil,
      price_per_number_of_guest: nil,
      specialization: nil,
      working_hours: nil
    }

    test "list_catering_services/0 returns all catering_services" do
      catering_service = catering_service_fixture()
      assert Catering.list_catering_services() == [catering_service]
    end

    test "get_catering_service!/1 returns the catering_service with given id" do
      catering_service = catering_service_fixture()
      assert Catering.get_catering_service!(catering_service.id) == catering_service
    end

    test "create_catering_service/1 with valid data creates a catering_service" do
      valid_attrs = %{
        available_days: "some available_days",
        business_email: "some business_email",
        business_name: "some business_name",
        business_phone_number: "some business_phone_number",
        description: "some description",
        image: "some image",
        price_per_number_of_guest: "some price_per_number_of_guest",
        specialization: "some specialization",
        working_hours: "some working_hours"
      }

      assert {:ok, %CateringService{} = catering_service} =
               Catering.create_catering_service(valid_attrs)

      assert catering_service.available_days == "some available_days"
      assert catering_service.business_email == "some business_email"
      assert catering_service.business_name == "some business_name"
      assert catering_service.business_phone_number == "some business_phone_number"
      assert catering_service.description == "some description"
      assert catering_service.image == "some image"
      assert catering_service.price_per_number_of_guest == "some price_per_number_of_guest"
      assert catering_service.specialization == "some specialization"
      assert catering_service.working_hours == "some working_hours"
    end

    test "create_catering_service/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catering.create_catering_service(@invalid_attrs)
    end

    test "update_catering_service/2 with valid data updates the catering_service" do
      catering_service = catering_service_fixture()

      update_attrs = %{
        available_days: "some updated available_days",
        business_email: "some updated business_email",
        business_name: "some updated business_name",
        business_phone_number: "some updated business_phone_number",
        description: "some updated description",
        image: "some updated image",
        price_per_number_of_guest: "some updated price_per_number_of_guest",
        specialization: "some updated specialization",
        working_hours: "some updated working_hours"
      }

      assert {:ok, %CateringService{} = catering_service} =
               Catering.update_catering_service(catering_service, update_attrs)

      assert catering_service.available_days == "some updated available_days"
      assert catering_service.business_email == "some updated business_email"
      assert catering_service.business_name == "some updated business_name"
      assert catering_service.business_phone_number == "some updated business_phone_number"
      assert catering_service.description == "some updated description"
      assert catering_service.image == "some updated image"

      assert catering_service.price_per_number_of_guest ==
               "some updated price_per_number_of_guest"

      assert catering_service.specialization == "some updated specialization"
      assert catering_service.working_hours == "some updated working_hours"
    end

    test "update_catering_service/2 with invalid data returns error changeset" do
      catering_service = catering_service_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Catering.update_catering_service(catering_service, @invalid_attrs)

      assert catering_service == Catering.get_catering_service!(catering_service.id)
    end

    test "delete_catering_service/1 deletes the catering_service" do
      catering_service = catering_service_fixture()
      assert {:ok, %CateringService{}} = Catering.delete_catering_service(catering_service)

      assert_raise Ecto.NoResultsError, fn ->
        Catering.get_catering_service!(catering_service.id)
      end
    end

    test "change_catering_service/1 returns a catering_service changeset" do
      catering_service = catering_service_fixture()
      assert %Ecto.Changeset{} = Catering.change_catering_service(catering_service)
    end
  end

  describe "bookings" do
    alias Betachef.Catering.Booking

    import Betachef.CateringFixtures

    @invalid_attrs %{booking_state: nil, end_date: nil, start_date: nil}

    test "list_bookings/0 returns all bookings" do
      booking = booking_fixture()
      assert Catering.list_bookings() == [booking]
    end

    test "get_booking!/1 returns the booking with given id" do
      booking = booking_fixture()
      assert Catering.get_booking!(booking.id) == booking
    end

    test "create_booking/1 with valid data creates a booking" do
      valid_attrs = %{
        booking_state: "some booking_state",
        end_date: "some end_date",
        start_date: "some start_date"
      }

      assert {:ok, %Booking{} = booking} = Catering.create_booking(valid_attrs)
      assert booking.booking_state == "some booking_state"
      assert booking.end_date == "some end_date"
      assert booking.start_date == "some start_date"
    end

    test "create_booking/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catering.create_booking(@invalid_attrs)
    end

    test "update_booking/2 with valid data updates the booking" do
      booking = booking_fixture()

      update_attrs = %{
        booking_state: "some updated booking_state",
        end_date: "some updated end_date",
        start_date: "some updated start_date"
      }

      assert {:ok, %Booking{} = booking} = Catering.update_booking(booking, update_attrs)
      assert booking.booking_state == "some updated booking_state"
      assert booking.end_date == "some updated end_date"
      assert booking.start_date == "some updated start_date"
    end

    test "update_booking/2 with invalid data returns error changeset" do
      booking = booking_fixture()
      assert {:error, %Ecto.Changeset{}} = Catering.update_booking(booking, @invalid_attrs)
      assert booking == Catering.get_booking!(booking.id)
    end

    test "delete_booking/1 deletes the booking" do
      booking = booking_fixture()
      assert {:ok, %Booking{}} = Catering.delete_booking(booking)
      assert_raise Ecto.NoResultsError, fn -> Catering.get_booking!(booking.id) end
    end

    test "change_booking/1 returns a booking changeset" do
      booking = booking_fixture()
      assert %Ecto.Changeset{} = Catering.change_booking(booking)
    end
  end
end

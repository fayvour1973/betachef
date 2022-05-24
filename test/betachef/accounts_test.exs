defmodule Betachef.AccountsTest do
  use Betachef.DataCase

  alias Betachef.Accounts

  describe "users" do
    alias Betachef.Accounts.User

    import Betachef.AccountsFixtures

    @invalid_attrs %{
      date_of_birth: nil,
      email: nil,
      first_name: nil,
      full_name: nil,
      home_town: nil,
      last_name: nil,
      nationality: nil,
      phone_number: nil,
      residential_address: nil,
      state_of_origin: nil,
      password: nil,
      password_confirmation: nil
    }

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
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
      }

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.date_of_birth == "some date_of_birth"
      assert user.email == "some email"
      assert user.first_name == "some first_name"
      assert user.full_name == "some first_name" <> " " <> "some last_name"
      assert user.home_town == "some home_town"
      assert user.last_name == "some last_name"
      assert user.nationality == "some nationality"
      assert user.phone_number == "some phone_number"
      assert user.residential_address == "some residential_address"
      assert user.state_of_origin == "some state_of_origin"
      assert user.password == "1234"
      assert user.password_confirmation == "1234"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        date_of_birth: "some updated date_of_birth",
        email: "some updated email",
        first_name: "some updated first_name",
        full_name: "some updated first_name" <> " " <> "some updated last_name",
        home_town: "some updated home_town",
        last_name: "some updated last_name",
        nationality: "some updated nationality",
        phone_number: "some updated phone_number",
        residential_address: "some updated residential_address",
        state_of_origin: "some updated state_of_origin",
        password: "1234",
        password_confirmation: "1234"
      }

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.date_of_birth == "some updated date_of_birth"
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.full_name == "some updated first_name" <> " " <> "some updated last_name"
      assert user.home_town == "some updated home_town"
      assert user.last_name == "some updated last_name"
      assert user.nationality == "some updated nationality"
      assert user.phone_number == "some updated phone_number"
      assert user.residential_address == "some updated residential_address"
      assert user.state_of_origin == "some updated state_of_origin"
      assert user.password == "1234"
      assert user.password_confirmation == "1234"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "payments" do
    alias Betachef.Accounts.Payment

    import Betachef.AccountsFixtures

    @invalid_attrs %{mode: nil}

    test "list_payments/0 returns all payments" do
      payment = payment_fixture()
      assert Accounts.list_payments() == [payment]
    end

    test "get_payment!/1 returns the payment with given id" do
      payment = payment_fixture()
      assert Accounts.get_payment!(payment.id) == payment
    end

    test "create_payment/1 with valid data creates a payment" do
      valid_attrs = %{mode: "some mode"}

      assert {:ok, %Payment{} = payment} = Accounts.create_payment(valid_attrs)
      assert payment.mode == "some mode"
    end

    test "create_payment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_payment(@invalid_attrs)
    end

    test "update_payment/2 with valid data updates the payment" do
      payment = payment_fixture()
      update_attrs = %{mode: "some updated mode"}

      assert {:ok, %Payment{} = payment} = Accounts.update_payment(payment, update_attrs)
      assert payment.mode == "some updated mode"
    end

    test "update_payment/2 with invalid data returns error changeset" do
      payment = payment_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_payment(payment, @invalid_attrs)
      assert payment == Accounts.get_payment!(payment.id)
    end

    test "delete_payment/1 deletes the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{}} = Accounts.delete_payment(payment)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_payment!(payment.id) end
    end

    test "change_payment/1 returns a payment changeset" do
      payment = payment_fixture()
      assert %Ecto.Changeset{} = Accounts.change_payment(payment)
    end
  end
end

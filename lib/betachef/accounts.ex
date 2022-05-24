defmodule Betachef.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Betachef.Repo

  alias Betachef.Accounts.User
  alias Betachef.Catering.Booking

  def data do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  # def query(CateringService, %{scope: :bookings, limit: limit, offset: offset}) do
  # CateringService
  # |> limit(^limit)
  # |> offset(^offset)
  # end

  def query(queryable, _params) do
    queryable
  end

  def authenticate(email, password) do
    user = Repo.get_by(User, email: email)

    with %{password_hash: password_hash} <- user,
         true <- Pbkdf2.verify_pass(password, password_hash) do
      {:ok, user}
    else
      _ -> :error
    end
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    Repo.get!(User, id)
    Repo.get_by!(User, id: id) |> Repo.preload(:bookings)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias Betachef.Accounts.Payment

  @doc """
  Returns the list of payments.

  ## Examples

      iex> list_payments()
      [%Payment{}, ...]

  """
  def list_payments do
    Repo.all(Payment)
  end

  @doc """
  Gets a single payment.

  Raises `Ecto.NoResultsError` if the Payment does not exist.

  ## Examples

      iex> get_payment!(123)
      %Payment{}

      iex> get_payment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_payment!(id), do: Repo.get!(Payment, id)

  @doc """
  Creates a payment.

  ## Examples

      iex> create_payment(%{field: value})
      {:ok, %Payment{}}

      iex> create_payment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_payment(attrs \\ %{}) do
    user = Repo.get(User, attrs.user_id)
    booking = Repo.get(Booking, attrs.booking_id)

    [url, headers] = [
      "https://api.paystack.co/transaction/initialize",
      [
        Authorization: "Bearer #{System.get_env("PAYSTACK_KEY")}",
        Accept: "Application/json; Charset=utf-8"
      ]
    ]

    {:ok, body} =
      Jason.encode(%{
        email: user.email,
        amount: Decimal.mult(booking.total_price, 100) |> Decimal.to_string()
      })

    {:ok, response} = HTTPoison.post(url, body, headers)
    {:ok, res_body} = response.body |> Jason.decode()
    ref_code = res_body["data"]["reference"]
    auth_url = res_body["data"]["authorization_url"]

    new_attrs =
      Map.merge(attrs, %{
        reference_code: ref_code,
        auth_url: auth_url,
        total_price: booking.total_price
      })

    %Payment{}
    |> Payment.changeset(new_attrs)
    |> Repo.insert()
  end

  def verify_payment(%Payment{} = payment) do
    [url, headers] = [
      "https://api.paystack.co/transaction/verify/#{payment.reference_code}",
      [
        Authorization: "Bearer #{System.get_env("PAYSTACK_KEY")}",
        Accept: "Application/json; Charset=utf-8"
      ]
    ]

    {:ok, response} = HTTPoison.get(url, headers)
    {:ok, res_body} = response.body |> Jason.decode()

    attrs = %{transaction_id: res_body["data"]["customer"]["id"], verified: res_body["status"]}

    payment
    |> Payment.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a payment.

  ## Examples

      iex> update_payment(payment, %{field: new_value})
      {:ok, %Payment{}}

      iex> update_payment(payment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_payment(%Payment{} = payment, attrs) do
    payment
    |> Payment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a payment.

  ## Examples

      iex> delete_payment(payment)
      {:ok, %Payment{}}

      iex> delete_payment(payment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_payment(%Payment{} = payment) do
    Repo.delete(payment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking payment changes.

  ## Examples

      iex> change_payment(payment)
      %Ecto.Changeset{data: %Payment{}}

  """
  def change_payment(%Payment{} = payment, attrs \\ %{}) do
    Payment.changeset(payment, attrs)
  end
end

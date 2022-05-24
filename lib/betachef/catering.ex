defmodule Betachef.Catering do
  @moduledoc """
  The Catering context.
  """

  import Ecto.Query, warn: false
  alias Betachef.Repo

  alias Betachef.Catering.Caterer

  def data do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(CateringService, %{scope: :bookings, limit: limit, offset: offset}) do
    CateringService
    |> limit(^limit)
    |> offset(^offset)
  end

  def query(queryable, _params) do
    queryable
  end

  @doc """
  Returns the list of caterers.

  ## Examples

      iex> list_caterers()
      [%Caterer{}, ...]

  """
  def list_caterers do
    Repo.all(Caterer)
  end

  @doc """
  Gets a single caterer.

  Raises `Ecto.NoResultsError` if the Caterer does not exist.

  ## Examples

      iex> get_caterer!(123)
      %Caterer{}

      iex> get_caterer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_caterer!(id), do: Repo.get!(Caterer, id)

  @doc """
  Creates a caterer.

  ## Examples

      iex> create_caterer(%{field: value})
      {:ok, %Caterer{}}

      iex> create_caterer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_caterer(attrs \\ %{}) do
    %Caterer{}
    |> Caterer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a caterer.

  ## Examples

      iex> update_caterer(caterer, %{field: new_value})
      {:ok, %Caterer{}}

      iex> update_caterer(caterer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_caterer(%Caterer{} = caterer, attrs) do
    caterer
    |> Caterer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a caterer.

  ## Examples

      iex> delete_caterer(caterer)
      {:ok, %Caterer{}}

      iex> delete_caterer(caterer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_caterer(%Caterer{} = caterer) do
    Repo.delete(caterer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking caterer changes.

  ## Examples

      iex> change_caterer(caterer)
      %Ecto.Changeset{data: %Caterer{}}

  """
  def change_caterer(%Caterer{} = caterer, attrs \\ %{}) do
    Caterer.changeset(caterer, attrs)
  end

  alias Betachef.Catering.CateringService

  @doc """
  Returns the list of catering_services.

  ## Examples

      iex> list_catering_services()
      [%CateringService{}, ...]

  """
  def list_catering_services(args) do
    query = from(c in CateringService)

    args
    |> Enum.reduce(query, fn
      {:words, term}, query ->
        pattern = "%#{term}%"

        from(q in query,
          join: b in assoc(q, :bookings),
          where:
            ilike(q.first_name, ^pattern) or ilike(q.last_name, ^pattern) or
              ilike(q.full_name, ^pattern) or ilike(b.account_number, ^pattern)
        )

      {:limit, limit}, query ->
        from u in query, limit: ^limit

      {:offset, offset}, query ->
        from u in query, offset: ^offset
    end)
    |> Repo.all()
    |> Repo.preload(:bookings)
  end

  @doc """
  Gets a single catering_service.

  Raises `Ecto.NoResultsError` if the Catering service does not exist.

  ## Examples

      iex> get_catering_service!(123)
      %CateringService{}

      iex> get_catering_service!(456)
      ** (Ecto.NoResultsError)

  """

  def get_catering_service!(id) do
    Repo.get!(CateringService, id)
    Repo.get_by!(CateringService, id: id) |> Repo.preload(:bookings)
  end

  @doc """
  Creates a catering_service.

  ## Examples

      iex> create_catering_service(%{field: value})
      {:ok, %CateringService{}}

      iex> create_catering_service(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_catering_service(attrs \\ %{}) do
    %CateringService{}
    |> CateringService.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a catering_service.

  ## Examples

      iex> update_catering_service(catering_service, %{field: new_value})
      {:ok, %CateringService{}}

      iex> update_catering_service(catering_service, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_catering_service(%CateringService{} = catering_service, attrs) do
    catering_service
    |> CateringService.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a catering_service.

  ## Examples

      iex> delete_catering_service(catering_service)
      {:ok, %CateringService{}}

      iex> delete_catering_service(catering_service)
      {:error, %Ecto.Changeset{}}

  """
  def delete_catering_service(%CateringService{} = catering_service) do
    Repo.delete(catering_service)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking catering_service changes.

  ## Examples

      iex> change_catering_service(catering_service)
      %Ecto.Changeset{data: %CateringService{}}

  """
  def change_catering_service(%CateringService{} = catering_service, attrs \\ %{}) do
    CateringService.changeset(catering_service, attrs)
  end

  alias Betachef.Catering.Booking

  @doc """
  Returns the list of bookings.

  ## Examples

      iex> list_bookings()
      [%Booking{}, ...]

  """
  def list_bookings do
    Repo.all(Booking)
  end

  @doc """
  Gets a single booking.

  Raises `Ecto.NoResultsError` if the Booking does not exist.

  ## Examples

      iex> get_booking!(123)
      %Booking{}

      iex> get_booking!(456)
      ** (Ecto.NoResultsError)

  """
  def get_booking!(id), do: Repo.get!(Booking, id)

  @doc """
  Creates a booking.

  ## Examples

      iex> create_booking(%{field: value})
      {:ok, %Booking{}}

      iex> create_booking(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_booking(attrs \\ %{}) do
    %Booking{}
    |> Booking.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a booking.

  ## Examples

      iex> update_booking(booking, %{field: new_value})
      {:ok, %Booking{}}

      iex> update_booking(booking, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_booking(%Booking{} = booking, attrs) do
    booking
    |> Booking.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a booking.

  ## Examples

      iex> delete_booking(booking)
      {:ok, %Booking{}}

      iex> delete_booking(booking)
      {:error, %Ecto.Changeset{}}

  """
  def delete_booking(%Booking{} = booking) do
    Repo.delete(booking)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking booking changes.

  ## Examples

      iex> change_booking(booking)
      %Ecto.Changeset{data: %Booking{}}

  """
  def change_booking(%Booking{} = booking, attrs \\ %{}) do
    Booking.changeset(booking, attrs)
  end
end

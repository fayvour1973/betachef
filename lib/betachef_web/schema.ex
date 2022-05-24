defmodule BetachefWeb.Schema do
  use Absinthe.Schema

  import_types(BetachefWeb.Schema.UserType)
  import_types(BetachefWeb.Schema.PaymentType)
  import_types(BetachefWeb.Schema.CaterersType)
  import_types(BetachefWeb.Schema.CateringServicesType)
  import_types(BetachefWeb.Schema.BookingsType)
  import_types(Absinthe.Type.Custom)

  alias Betachef.Accounts
  alias Betachef.Catering
  # alias Betachef.Catering.CateringService
  alias BetachefWeb.Resolvers.Accounts
  alias BetachefWeb.Resolvers.Catering
  alias BetachefWeb.Schema.Middleware

  # def context(ctx) do
  # source = Dataloader.Ecto.new(Betachef.Repo)

  # loader =
  # Dataloader.new()
  # |> Dataloader.add_source(BetachefWeb.Resolvers.Catering, Betachef.Catering.data())
  # |> Dataloader.add_source(BetachefWeb.Resolvers.Catering, source)
  # |> Dataloader.load(Catering, CateringService, :bookings)
  # |> Dataloader.load_many(Catering, :bookings, :catering_services)
  # |> Dataloader.run()

  # Map.put(ctx, :loader, loader)
  # end

  # def context(ctx) do
  # loader =
  # Dataloader.Ecto.new(Betachef.)
  # |> Dataloader.load(Catering, :bookings_type, catering_service_type)
  # |> Dataloader.load_many(Catering, :catering_services_type, bookings)
  # |> Dataloader.run()

  # loader =
  # Dataloader.new()
  # |> Dataloader.add_source(
  # Betachef.Accounts,
  # Betachef.Accounts.data()
  # )
  # |> #Dataloader.add_source(Catering, Betachef.Catering.data())
  # |> Dataloader.add_source(Catering.CateringService, Betachef.Catering.data())
  # |> Dataloader.add_source(Catering.Booking, Betachef.Catering.data())

  # Map.put(ctx, :loader, loader)
  # end

  # def plugins do
  # [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  # end

  def context(ctx) do
    IO.inspect(ctx)
    # ctx = Map.put(ctx, :current_user, Betachef.Accounts.get_user!(1))

    loader = Dataloader.new()
    # |> Dataloader.add_source(Accounts, Accounts.datasource())
    # |> Dataloader.add_source(Catering, Catering.datasource())

    Map.put(ctx, :loader, loader)
  end

  object :session do
    field :user, non_null(:users_type)
    field :token, non_null(:string)
  end

  query do
    @desc "Get all users"
    field :users, list_of(:users_type) do
      resolve(&Accounts.list_users/3)
    end

    @desc "Get a user by its id"
    field :users1, :users_type do
      arg(:id, :id)
      resolve(&Accounts.get_users/3)
    end

    @desc "Get all payments"
    field :payment, list_of(:payments_type) do
      resolve(&Accounts.list_payments/3)
    end

    @desc "Get all caterer"
    field :cateters, list_of(:caterers_type) do
      resolve(&Catering.list_caterers/3)
    end

    @desc "Get all catering services"
    field :catering_services, list_of(:catering_services_type) do
      resolve(&Catering.list_catering_services/3)
    end

    @desc "Get a catering services by its id"
    field :catering_services1, :catering_services_type do
      arg(:id, :id)
      resolve(&Catering.get_catering_services/3)
    end

    @desc "Get all bookings"
    field :bookings, list_of(:bookings_type) do
      resolve(&Catering.list_bookings/3)
    end

    @desc "Get a list of all catering services"
    field :all_catering_services, list_of(:catering_services_type) do
      arg(:limit, :integer)
      arg(:offset, :integer)
      resolve(&Catering.list_catering_services/3)
    end
  end

  mutation do
    @desc "Create_users"
    field :create_user, type: :users_type do
      arg(:date_of_birth, :string)
      arg(:email, :string)
      arg(:first_name, :string)
      arg(:home_town, :string)
      arg(:last_name, :string)
      arg(:nationality, :string)
      arg(:phone_number, :string)
      arg(:residential_address, :string)
      arg(:state_of_origin, :string)
      arg(:password, :string)
      arg(:password_confirmation, :string)
      resolve(&Accounts.create_users/3)
    end

    @desc "Create a user account"
    field :sign_up, :session do
      arg(:date_of_birth, :string)
      arg(:email, :string)
      arg(:first_name, :string)
      arg(:last_name, :string)
      arg(:nationality, :string)
      arg(:phone_number, :string)
      arg(:home_town, :string)
      arg(:residential_address, :string)
      arg(:state_of_origin, :string)
      arg(:password, :string)
      arg(:password_confirmation, :string)
      resolve(&Accounts.sign_up/3)
    end

    @desc "create payments"
    field :create_payment, type: :payments_type do
      arg(:user_id, :id)
      arg(:booking_id, :id)
      resolve(&Accounts.create_payments/3)
    end

    @desc "verify payment"
    field :verify_payment, type: :payments_type do
      arg(:payment_id, :id)
      resolve(&Accounts.verify_payment/3)
    end
   #This is a new change
    @desc "create caterers"
    field :create_caterer, type: :caterers_type do
      arg(:country, :string)
      arg(:email, :string)

      arg(:first_name, :string)
      arg(:full_name, :string)
      arg(:last_name, :string)
      arg(:phone_number, :string)
      resolve(&Catering.create_caterers/3)
    end

    @desc "create catering services"
    field :create_catering_service, type: :catering_services_type do
      arg(:available_days, :string)
      arg(:business_email, :string)
      arg(:business_phone_number, :string)
      arg(:business_name, :string)
      arg(:description, :string)
      arg(:image, :string)
      arg(:price_per_number_of_guest, :string)
      arg(:price_per_day, :decimal)
      arg(:specialization, :string)
      arg(:working_hours, :string)
      arg(:caterer_id, :id)
      resolve(&Catering.create_catering_services/3)
    end

    @desc "Delete catering service"
    field :delete_catering_service, type: :catering_services_type do
      arg(:catering_service_id, non_null(:id))
      resolve(&Catering.delete_catering_services/3)
    end

    @desc "create bookings"
    field :create_booking, type: :bookings_type do
      arg(:end_date, :string)
      arg(:start_date, :string)
      arg(:booking_state, :string)
      arg(:user_id, :id)
      arg(:catering_service_id, :id)
      middleware(Middleware.Authenticate)
      resolve(&Catering.create_bookings/3)
    end

    @desc "Delete bookings"
    field :delete_booking, type: :bookings_type do
      arg(:catering_service_id, non_null(:id))
      resolve(&Catering.delete_bookings/3)
    end

    @desc "login a user"
    field :login_user, type: :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Accounts.user_login/3)
    end
  end

  subscription do
    #This is our new subscription feature
    @desc "subscribe to booking changes for a catering service"
    field :booking_change, :bookings_type do
      arg(:catering_service_id, non_null(:id))

      config(fn args, _res ->
        {:ok, topic: args.catering_service_id}
      end)
    end
  end
end

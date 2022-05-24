defmodule BetachefWeb.Resolvers.Accounts do
  alias Betachef.Accounts
  alias Betachef.Accounts.Payment
  alias BetachefWeb.AuthToken
  alias Betachef.Repo

  def list_users(_parent, _args, _resolution) do
    {:ok, Accounts.list_users()}
  end

  def get_users(_parent, %{id: id}, _resolution) do
    {:ok, Accounts.get_user!(id)}
  end

  def list_payments(_parent, _args, _resolution) do
    {:ok, Accounts.list_payments()}
  end

  def create_users(_parent, args, _resolution) do
    Accounts.create_user(args)
  end

  @spec create_payments(any, %{:booking_id => any, :user_id => any, optional(any) => any}, any) ::
          any
  def create_payments(_parent, args, _resolution) do
    Accounts.create_payment(args)
  end

  def verify_payment(_parent, %{payment_id: payment_id}, _resolution) do
    {:ok, payment} = Repo.get(Payment, payment_id)
    {:ok, Accounts.verify_payment(payment)}
  end

  @spec sign_up(
          any,
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any},
          any
        ) :: {:ok, %{token: nonempty_binary, user: atom | %{:id => any, optional(any) => any}}}
  def sign_up(_, args, _) do
    case Accounts.create_user(args) do
      {:ok, user} ->
        token = AuthToken.sign(user)
        {:ok, %{user: user, token: token}}
    end
  end

  def user_login(_, %{email: email, password: password}, _) do
    case Accounts.authenticate(email, password) do
      {:ok, user} ->
        token = AuthToken.sign(user)
        {:ok, %{user: user, token: token}}
    end
  end
end

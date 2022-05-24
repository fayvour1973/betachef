defmodule BetachefWeb.UserSocket do
  use Phoenix.Socket
  use Absinthe.Phoenix.Socket, schema: BetachefWeb.Schema

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  @spec id(any) :: nil
  def id(_socket), do: nil
end

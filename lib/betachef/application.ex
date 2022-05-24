defmodule Betachef.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Betachef.Repo,
      # Start the Telemetry supervisor
      BetachefWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Betachef.PubSub},
      # Start the Endpoint (http/https)
      BetachefWeb.Endpoint,
      # Start a worker by calling: Betachef.Worker.start_link(arg)
      # {Betachef.Worker, arg}
      {Absinthe.Subscription, [BetachefWeb.Endpoint]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Betachef.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BetachefWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

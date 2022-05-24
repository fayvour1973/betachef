defmodule Betachef.Repo do
  use Ecto.Repo,
    otp_app: :betachef,
    adapter: Ecto.Adapters.Postgres
end

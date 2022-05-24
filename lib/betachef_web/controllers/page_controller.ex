defmodule BetachefWeb.PageController do
  use BetachefWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

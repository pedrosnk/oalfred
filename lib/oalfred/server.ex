defmodule Oalfred.Server do
  use Plug.Router

  plug Plug.Logger, log: :debug
  plug :match
  plug :dispatch

  get "/auth" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{auth: true}))
  end

end

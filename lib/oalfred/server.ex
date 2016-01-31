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

  get "/users/:name" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{username: name}))
  end

  get "/users" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{users: []}))
  end

  post "/users" do
    {:ok, body, _} = read_body(conn)
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(201, body)
  end

  put "/users" do
    {:ok, body, _} = read_body(conn)
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end

  delete "/users/:name" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{username: name}))
  end

end

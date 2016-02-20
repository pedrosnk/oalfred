defmodule Oalfred.Server do
  use Plug.Router

  plug Plug.Logger, log: :debug
  plug :match
  plug :dispatch

  def init _ do
    IO.puts "starting server"
    Oalfred.AgentStore.start_link
  end

  get "/auth" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{auth: true}))
  end

  get "/users/:id" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{name: "", id: id}))
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

  delete "/users/:id" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{name: "", id: id}))
  end

end

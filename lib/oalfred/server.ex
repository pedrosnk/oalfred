defmodule Oalfred.Server do
  use Plug.Router

  alias Oalfred.AgentStore, as: Store
  alias Oalfred.User

  plug Plug.Logger, log: :debug
  plug :match
  plug :dispatch

  def init _ do
    IO.puts "starting server"
    Store.start_link
  end

  get "/auth" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{auth: true}))
  end

  get "/users/:id" do
    user = Store.get_user_by_id(id)
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(user))
  end

  get "/users" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{users: []}))
  end

  post "/users" do
    {:ok, body, _} = read_body(conn)
    
    user = Store.add_user Poison.decode!(body)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(201, Poison.encode!(user))
  end

  put "/users/:id" do
    {:ok, body, _} = read_body(conn)
    body = Poison.decode!(body)

    user = Store.get_user_by_id(id) 
           |> Map.merge(body)

    user = Store.update_user user
    
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(user))
  end

  delete "/users/:id" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{name: "", id: id}))
  end

end

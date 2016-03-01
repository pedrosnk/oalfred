defmodule OalfredTest do
  use ExUnit.Case
  use Plug.Test

  @otps Oalfred.Server.init([])

  setup do
    Agent.start_link fn -> MapSet.new end, name: Oalfred.AgentStore
    Agent.update Oalfred.AgentStore, fn _ ->
      MapSet.new [
        %{name: "John Doe", id: "123"},
        %{name: "Foo Bar", id: "456"},
      ]
    end
  end

  test "Testing basic auth" do
    conn = conn(:get, "/auth")

    conn = Oalfred.Server.call(conn, @otps)

    assert conn.status == 200
    assert conn.resp_body == ~s({"auth":true})
  end

  test "GET /users/:id" do
    conn = conn(:get, "/users/123")
      |> Oalfred.Server.call(@otps)

    assert conn.status == 200
    assert conn.resp_body =~ ~s(John Doe)
    assert conn.resp_body =~ ~s(123)
  end

  test "POST /user" do
    conn = conn(:post, "/users", ~s({"name": "Bar Baz"}))
      |> Oalfred.Server.call(@otps)

    assert conn.status == 201
    assert conn.resp_body =~ ~s(Bar Baz)
    assert conn.resp_body =~ ~s(id)
  end
end

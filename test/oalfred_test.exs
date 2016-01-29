defmodule OalfredTest do
  use ExUnit.Case
  use Plug.Test

  @otps Oalfred.init([])

  test "Testing basic auth" do
    conn = conn(:get, "/auth")

    conn = Oalfred.call(conn, @otps)

    assert conn.status == 200
    assert conn.resp_body == ~s({"auth":true})
  end
end

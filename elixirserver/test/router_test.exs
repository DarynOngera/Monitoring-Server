defmodule Elixirserver.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts Elixirserver.Router.init([])

  test "GET /health returns 200" do
    conn = conn(:get, "/health")
    conn = Elixirserver.Router.call(conn, @opts)

    assert conn.status == 200
    assert conn.resp_body == "OK"
  end
end


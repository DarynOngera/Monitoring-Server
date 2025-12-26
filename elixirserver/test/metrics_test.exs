defmodule Elixirserver.MetricsTest do
  use ExUnit.Case
  
  import Plug.Test
  import Plug.Conn
  import ExUnit.CaptureLog

  @router_opts Elixirserver.Router.init([])

  test "metrics endpoint returns valid Prometheus metrics" do
    # Make a request to /health to generate metrics
    conn(:get, "/health")
    |> Elixirserver.Router.call(@router_opts)

    # Start a simple HTTP request to the metrics endpoint
     {:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, body}} =
      :httpc.request('http://localhost:4001/metrics')

    body = to_string(body)

    assert String.contains?(body, "server_http_request_count")
    assert String.contains?(body, "server_http_request_duration")
  end
end


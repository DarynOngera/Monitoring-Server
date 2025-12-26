defmodule Elixirserver.TelemetryTest do
  use ExUnit.Case
  use Plug.Test

  @opts Elixirserver.Router.init([])

  test "telemetry events are emitted on request" do
    :telemetry.attach(
      "test-handler",
      [:server, :http, :stop],
      fn _event, _measurements, _metadata, pid ->
        send(pid, :telemetry_received)
      end,
      self()
    )

    conn(:get, "/health")
    |> Elixirserver.Router.call(@opts)

    assert_receive :telemetry_received

    :telemetry.detach("test-handler")
  end
end


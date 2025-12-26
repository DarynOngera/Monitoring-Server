defmodule Elixirserver.Metrics do
  alias Telemetry.Metrics

  def metrics do
    [
      # Count of HTTP requests
      Metrics.counter("server.http.request.count",
        event_name: [:server, :http, :stop] # Plug.Telemetry stop event
      ),

      # Duration of HTTP requests in milliseconds
      Metrics.last_value("server.http.request.duration",
        event_name: [:server, :http, :stop],
        measurement: :duration,
        unit: {:native, :millisecond}
      )
    ]
  end
end


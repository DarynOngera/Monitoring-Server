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
      ),

      # Worker metrics
      Metrics.counter("worker.job.received.count",
        event_name: [:worker, :job, :received],
        measurement: :count
      ),

      Metrics.counter("worker.job.completed.count",
        event_name: [:worker, :job, :completed],
        measurement: :count
      ),

      # Worker lifecycle
      Metrics.counter("worker.started.count",
        event_name: [:worker, :lifecycle, :started],
        measurement: :count
      ),

      Metrics.counter("worker.terminated.count",
        event_name: [:worker, :lifecycle, :terminated],
        measurement: :count
      ),

      # Worker crashes
      Metrics.counter("worker.crash.count",
        event_name: [:worker, :crash],
        measurement: :count
      )

    ]
  end
end


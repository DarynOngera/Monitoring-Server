require Logger
defmodule Elixirserver.MetricsExporter do 
  use GenServer

  alias TelemetryMetricsPrometheus

  @port 4001 

  def start_link(_) do 
    case GenServer.start_link(__MODULE__, [], name: __MODULE__) do 
      {:ok, pid} ->
        Logger.info("Metrics available on http://localhost:4001/metrics")
        {:ok, pid}
    end
  end 

  @impl true 
  def init(_) do 
    # Start Prometheus reporter 
    {:ok, _pid} = 
      TelemetryMetricsPrometheus.start_link(metrics: Elixirserver.Metrics.metrics(), port: @port)

    {:ok, %{}}
  end
end 

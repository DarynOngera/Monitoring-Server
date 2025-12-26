defmodule Elixirserver.MetricsExporter do 
  use GenServer

  alias TelemetryMetricsPrometheus

  @port 4001 

  def start_link(_) do 
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end 

  @impl true 
  def init(_) do 
    # Start Prometheus reporter 
    {:ok, _pid} = 
      TelemetryMetricsPrometheus.start_link(metrics: Elixirserver.Metrics.metrics(), port: @port)

    {:ok, %{}}
  end
end 

require Logger 
defmodule Elixirserver.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Elixirserver.Router, options: [port: 4000]},
      {Elixirserver.MetricsExporter, []},
      {Elixirserver.Worker, []}
    ]

    opts = [strategy: :one_for_one, name: Elixirserver.Supervisor]
  case  Supervisor.start_link(children, opts) do
      {:ok, pid} ->
        Logger.info("Server started on PORT:4000")
        {:ok, pid}

      error ->
        error
  end
  end
end

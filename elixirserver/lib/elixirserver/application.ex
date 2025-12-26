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
    Supervisor.start_link(children, opts)
  end
end

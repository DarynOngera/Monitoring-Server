defmodule Elixirserver.Worker do
  use GenServer

  @moduledoc """
  A simple supervised worker that can crash intentionally for testing purposes.
  """

  # Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def crash do
    GenServer.cast(__MODULE__, :crash)
  end

  # Server Callbacks
  @impl true
  def init(_opts) do
    {:ok, %{count: 0}}
  end

  @impl true
  def handle_cast(:crash, state) do
    # Simulate a failure
    raise "Intentional crash"
    {:noreply, state}
  end
end


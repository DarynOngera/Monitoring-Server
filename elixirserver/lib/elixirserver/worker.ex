defmodule Elixirserver.Worker do
  use GenServer
  require Logger


  # Public API
  def start_link(_) do 
    GenServer.start_link(__MODULE__, %{
      processed: 0,
      failed: 0
    }, name: __MODULE__)
  end

  def submit_job(payload) do 
    GenServer.cast(__MODULE__, {:job, payload})
  end

  def crash do
    GenServer.cast(__MODULE__, :crash)
  end

  def stats do 
    GenServer.call(__MODULE__, :stats)
  end 

  # Server Callbacks
  @impl true
  def init(state) do
    Logger.info("Worker started")
    
    :telemetry.execute(
      [:worker, :lifecycle, :started],
      %{count: 1},
      %{}
    )

    {:ok, state}
  end

  @impl true
  def handle_cast({:job, payload}, state) do
    :telemetry.execute(
      [:worker, :job, :received],
      %{count: 1},
      %{payload: payload}
    )

    # Simulate work
    Process.sleep(50)

    new_state = %{state | processed: state.processed + 1}

    :telemetry.execute(
      [:worker, :job, :completed],
      %{count: 1},
      %{}
    )

    {:noreply, new_state}
  end

  @impl true 
  def handle_cast(:crash, state) do
    :telemetry.execute(
      [:worker, :crash],
      %{count: 1},
      %{}
    )

    Logger.error("Intentional worker crash")
    raise "Intentional crash"
  end

  @impl true
  def terminate(reason, _state) do
    :telemetry.execute(
      [:worker, :lifecycle, :terminated],
      %{count: 1},
      %{reason: reason}
    )

    :ok
  end

  @impl true
  def handle_call(:stats, _from, state) do
    {:reply, state, state}
  end
end


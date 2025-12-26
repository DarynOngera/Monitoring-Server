defmodule Elixirserver.WorkerTest do
  use ExUnit.Case

  test "worker restarts after crash" do
    pid = Process.whereis(Elixirserver.Worker)
    assert Process.alive?(pid)

    # Crash the worker
    Elixirserver.Worker.crash()

    # Allow a small delay for restart
    Process.sleep(100)

    new_pid = Process.whereis(Server.Worker)
    assert Process.alive?(new_pid)
    assert new_pid != pid
  end
end


defmodule ElixirserverTest do
  use ExUnit.Case
  doctest Elixirserver

  test "application supervisor starts" do
    assert Process.whereis(Elixirserver.Supervisor)
  end
end

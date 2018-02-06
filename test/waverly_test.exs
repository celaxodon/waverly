defmodule WaverlyTest do
  use ExUnit.Case
  doctest Waverly

  test "greets the world" do
    assert Waverly.hello() == :world
  end
end

defmodule SinkholeTest do
  use ExUnit.Case
  doctest Sinkhole

  test "greets the world" do
    assert Sinkhole.hello() == :world
  end
end

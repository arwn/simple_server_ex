defmodule SimpleServerExTest do
  use ExUnit.Case
  doctest SimpleServerEx

  test "greets the world" do
    assert SimpleServerEx.hello() == :world
  end
end

defmodule SimpleServerEx.Counter do
  @moduledoc """
  Counter provides an incremental counter.
  """
  use GenServer

  @spec start_link(number()) :: :ignore | {:error, any} | {:ok, pid}
  @doc """
  Start the count server.
  """
  # client
  def start_link(initial \\ 0) do
    GenServer.start_link(__MODULE__, initial, name: __MODULE__)
  end

  @doc """
  Increments the counter and returns the new count.

  ## Examples

      iex> for _i <- 1..10, do: SimpleServerEx.Counter.count()
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  """
  def count() do
    GenServer.call(__MODULE__, :count)
  end

  # server
  @impl true
  def init(initial) do
    {:ok, initial}
  end

  @impl true
  def handle_call(:count, _from, state) do
    {:reply, state + 1, state + 1}
  end

  @impl true
  def handle_cast(_message, state) do
    {:noreply, state}
  end

end

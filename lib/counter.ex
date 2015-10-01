defmodule Docs.Counter do
  use GenServer

  def inc(counter) do
    GenServer.cast(counter, :inc)
  end

  def dec(counter) do
    GenServer.cast(counter, :dec)
  end

  def val(counter) do
    GenServer.call(counter, :val)
  end

  def start_link(initial_value \\ 0) do
    GenServer.start_link(__MODULE__, initial_value, name: :counter)
  end

  def init(initial_value) do
    :timer.send_interval(2000, :tick)
    {:ok, initial_value}
    # :error, :ignore
  end

  def handle_info(:tick, val) do
    #IO.puts "tick #{val}"
    if val < 5, do: raise("Boom")
    {:noreply, val - 1}
  end

  def handle_cast(:inc, val) do
    {:noreply, val + 1}
  end

  def handle_cast(:dec, val) do
    {:noreply, val - 1}
  end

  def handle_call(:val, _from, val) do
    # second arg is reply to client
    # third arg is state
    {:reply, val, val}
  end
end

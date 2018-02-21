defmodule Sinkhole do
  use GenMQTT
  @moduledoc """
  Documentation for Sinkhole.
  """

  def start_link(topic) do
    GenMQTT.start_link(__MODULE__, [topic], [{:host, "euterpe3"}])
  end

  def on_connect(state) do
    IO.puts "on_connect(#{state}): Connected. Subscribing..."
    :ok = GenMQTT.subscribe(self(), "room/+/temp", 0)
    {:ok, state}
  end

  def on_publish(["room", location, "temp"], message, state) do
    IO.puts "It is #{message} degrees in #{location}"
    {:ok, state}
  end

  @doc """
  Hello world.

  ## Examples

      iex> Sinkhole.hello
      :world

  """
  def hello do
    :world
  end
end

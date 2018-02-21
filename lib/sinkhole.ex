defmodule Sinkhole do
  use Application
  require Logger

  def start(type, args) do
    Logger.info("Sinkhole.start(#{type}, #{args})")
    Sinkhole.Supervisor.start_link(name: Sinkhole.Supervisor)
  end

  @moduledoc """
  Documentation for Sinkhole.
  """
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

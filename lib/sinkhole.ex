defmodule Sinkhole do
  use Application

  def start(_type, _args) do
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

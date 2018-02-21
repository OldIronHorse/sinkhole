defmodule Sinkhole.Supervisor do
  use Supervisor
  require Logger

  def start_link(opts) do
    Logger.info("Sinkhole.Supervisor.start_link(#{Kernel.inspect(opts)})")
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      {Sinkhole.Listener, domain: "home"},
      {Sinkhole.Listener, domain: "office"}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end

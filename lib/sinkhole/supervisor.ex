defmodule Sinkhole.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      {Sinkhole.Listener, domain: "home"}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end

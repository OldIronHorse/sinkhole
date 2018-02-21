defmodule Sinkhole.Supervisor do
  use Supervisor

  def start_link(opts) do
    IO.puts("Sinkhole.Supervisor.start_link(")
    IO.inspect(opts)
    IO.puts(")")
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

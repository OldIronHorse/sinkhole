defmodule Sinkhole.Listener do
  use GenMQTT
  def start_link(opts) do
    IO.puts("Sinkhole.Listener.start_link(")
    IO.inspect(opts)
    IO.puts(")")
    GenMQTT.start_link(__MODULE__, opts[:domain], [{:host, "euterpe3"}])
  end

  def init(args) do
    IO.puts("Sinkhole.Listener.init(")
    IO.inspect(args)
    IO.puts(")")
    {:ok, args}
  end

  def child_spec(opts) do
    IO.puts("Sinkhole.Listener.child_spec(")
    IO.inspect(opts)
    IO.puts(")")
    %{
      id: "#{__MODULE__}/#{opts[:domain]}",
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  def on_connect(domain) do
    IO.puts("on_connect(#{domain}): Connected. Subscribing...")
    :ok = GenMQTT.subscribe(self(), "#{domain}/#", 0)
    {:ok, domain}
  end

  def on_publish([domain | location], message, domain) do
    IO.puts("[#{domain}] It is #{message} degrees in #{location}")
    {:ok, domain}
  end
end



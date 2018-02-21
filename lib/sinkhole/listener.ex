defmodule Sinkhole.Listener do
  use GenMQTT
  require Logger
  
  def start_link(opts) do
    Logger.info("Sinkhole.Listener.start_link(#{Kernel.inspect(opts)})")
    GenMQTT.start_link(__MODULE__, opts[:domain], [{:host, opts[:mqtt_host]}])
  end

  def init(args) do
    Logger.info("Sinkhole.Listener.init(#{Kernel.inspect(args)})")
    {:ok, args}
  end

  def child_spec(opts) do
    Logger.info("Sinkhole.Listener.child_spec(#{Kernel.inspect(opts)})")
    %{
      id: "#{__MODULE__}/#{opts[:domain]}",
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  def on_connect(domain) do
    Logger.info("Sinkhole.Listener.on_connect(#{domain}): Connected. Subscribing to #{domain}/#")
    :ok = GenMQTT.subscribe(self(), "#{domain}/#", 0)
    {:ok, domain}
  end

  def on_publish([domain, location, _parameter], message, domain) do
    Logger.info("Sinkhole.Listener.on_publish: [#{domain}] It is #{message} degrees in the #{location}")
    {:ok, domain}
  end
end



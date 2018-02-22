defmodule Sinkhole.Listener do
  use GenMQTT
  require Logger

  def start_link(opts) do
    Logger.info("opts=#{Kernel.inspect(opts)}")
    GenMQTT.start_link(__MODULE__, opts[:domain], [{:host, opts[:mqtt_host]}])
  end

  def init(args) do
    Logger.info("args=#{Kernel.inspect(args)}")
    {:ok, args}
  end

  def child_spec(opts) do
    Logger.info("opts=#{Kernel.inspect(opts)}")

    %{
      id: "#{__MODULE__}/#{opts[:domain]}",
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  def on_connect(domain) do
    Logger.info("Connected. Subscribing to #{domain}/+/+")
    :ok = GenMQTT.subscribe(self(), "#{domain}/+/+", 0)
    {:ok, domain}
  end

  def on_publish([domain, location, parameter], message, domain) do
    Logger.info("[#{domain}] It is #{message} degrees in the #{location}")

    Mongo.insert_one(:mongo, domain, [
      {parameter, message},
      {"location", location}
    ])

    {:ok, domain}
  end
end

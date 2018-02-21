defmodule Sinkhole.Supervisor do
  use Supervisor
  require Logger

  def start_link(opts) do
    Logger.info("Sinkhole.Supervisor.start_link(#{Kernel.inspect(opts)})")
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    domains = Application.get_env(:sinkhole, :domains)
    mqtt_host = Application.get_env(:sinkhole, :mqtt_host, "localhost")
    Logger.info("Sinkhole.Supervisor.init: domains=#{Kernel.inspect(domains)}, mqtt_host=#{Kernel.inspect(mqtt_host)}")

    children = for domain <- domains do 
      {Sinkhole.Listener, [domain: domain, mqtt_host: mqtt_host]}
    end

    Supervisor.init(children, strategy: :one_for_one)
  end
end

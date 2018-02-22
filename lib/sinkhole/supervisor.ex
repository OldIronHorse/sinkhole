defmodule Sinkhole.Supervisor do
  use Supervisor
  require Logger

  def start_link(opts) do
    Logger.info("opts=#{Kernel.inspect(opts)}")
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    domains = Application.get_env(:sinkhole, :domains)
    mqtt_host = Application.get_env(:sinkhole, :mqtt_host, "localhost")
    db_url = Application.get_env(:sinkhole, :db_url)

    Logger.info(
      "domains=#{Kernel.inspect(domains)}, mqtt_host=#{Kernel.inspect(mqtt_host)}, db_url=#{
        db_url
      }"
    )

    listeners =
      for domain <- domains do
        {Sinkhole.Listener, [domain: domain, mqtt_host: mqtt_host]}
      end

    db = {Mongo, url: db_url, name: :mongo}

    Supervisor.init([db | listeners], strategy: :one_for_one)
  end
end

# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :sinkhole, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:sinkhole, :key)
#
# You can also configure a 3rd-party app:
#
#     config :logger, level: :info
#
config :sinkhole,
  mqtt_host: "euterpe3",
  domains: ["home", "office", "cottage"],
  db_url: "mongodb://localhost:27017/sinkhole"

config :logger,
  backends: [
    # ,
    :console
    #    {Mongo.Logger, :mongodb}
  ]

config :logger, :console,
  metadata: [:application, :module, :function, :pid],
  # metadata_filter: [],
  compile_time_purge_level: :info,
  level: :info

config :logger, :mongodb, level: :debug
# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"

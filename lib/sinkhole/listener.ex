defmodule Sinkhole.Listener do
  use GenMQTT
  def start_link() do
    GenMQTT.start_link(__MODULE__, "home", [{:host, "euterpe3"}])
  end

  def on_connect(domain) do
    IO.puts("on_connect(#{domain}): Connected. Subscribing...")
    :ok = GenMQTT.subscribe(self(), "#{domain}/#", 0)
    {:ok, domain}
  end

  def on_publish([domain | location], message, domain) do
    IO.puts("It is #{message} degrees in #{location}")
    {:ok, domain}
  end
end



defmodule Elixirserver.Router do 
  use Plug.Router

  plug :match
  plug Plug.Telemetry, event_prefix: [:server, :http]
  plug :dispatch

  get "/health" do 
    send_resp(conn, 200, "OK")
  end 

  match _ do 
    send_resp(conn, 404, "Not Found")
  end 
end 


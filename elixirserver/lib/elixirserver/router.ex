defmodule Elixirserver.Router do 
  use Plug.Router

  plug :match
  plug Plug.Telemetry, event_prefix: [:server, :http]
  plug :dispatch

  get "/" do 
    send_resp(conn, 200, "Server is running")
  end 

  get "/health" do 
    send_resp(conn, 200, "OK")
  end


  match _ do 
    send_resp(conn, 404, "Not Found")
  end 
end 


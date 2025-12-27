require Logger
defmodule Elixirserver.Router do 
  use Plug.Router

  plug Plug.Logger, log: :info
  plug :match
  plug Plug.Telemetry, event_prefix: [:server, :http]
  plug :dispatch

  get "/" do 
    send_resp(conn, 200, "Server is running")
  end 

  get "/health" do
    worker_alive = Process.whereis(Elixirserver.Worker) != nil

    status =
      if worker_alive do
        "OK"
      else
        "DEGRADED"
      end

    send_resp(conn, 200, status)
  end


  #job system
  post "/jobs" do
    {:ok, body, _} = Plug.Conn.read_body(conn)
    Elixirserver.Worker.submit_job(body)
    send_resp(conn, 202, "Job accepted")
  end

  get "/jobs/stats" do
    stats = Elixirserver.Worker.stats()
    
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(stats))
  end

  #Chaos engineering
  post "/chaos/crash-worker" do
    Elixirserver.Worker.crash()
    send_resp(conn, 200, "Worker crashing")
  end

  get "/worker/status" do
    pid = Process.whereis(Elixirserver.Worker)

    status =
      if pid && Process.alive?(pid) do
        %{status: "running", pid: inspect(pid)}
      else
        %{status: "down"}
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(status))
  end


  match _ do 
    send_resp(conn, 404, "Not Found")
  end 
end 


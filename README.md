# Elixir Monitoring Server

An **open-source, production-oriented Elixir HTTP server** designed with an explicit focus on **reliability, observability, and clean system architecture**. The project models how modern backend services should be structured when long-running stability, introspection, and operational visibility are first-class concerns.

At its core, the system leverages **Elixir and OTP supervision trees** to ensure fault isolation and automatic recovery from failures. Application components such as the HTTP server, metrics exporter, and background workers are supervised independently, allowing the system to remain available even when individual processes crash.

Observability is implemented using **Telemetry** as the instrumentation layer, enabling consistent and low-overhead emission of application and request-level events. These events are translated into **Prometheus-compatible metrics**, which are exposed through a dedicated `/metrics` endpoint. **Grafana** is then used to visualize request rates, latency distributions, error patterns, and overall system health, providing real-time operational insight.

The project emphasizes clarity over abstraction, avoiding unnecessary frameworks while adhering to established backend and infrastructure best practices. Its structure is intentionally modular to allow extension into distributed systems, alerting pipelines, containerized deployments, or orchestration environments. As such, it serves both as a reference implementation and a foundation for more advanced reliability and monitoring-focused systems.

---
## Features

* HTTP server using Plug + Cowboy
* OTP supervision trees for fault tolerance
* Supervised background worker with automatic restart
* Application, request and worker metrics via Telemetry
* Prometheus-compatible `/metrics` endpoint
* Grafana-ready metrics
* Health and worker health endpoints
* Modular and extensible architecture

---

## High-Level Architecture

```
Client ──HTTP──▶ Plug Router ──▶ OTP Supervision Tree
                          │
                          ├── Telemetry Events
                          │        │
                          ▼        ▼
                     /metrics   Prometheus ──▶ Grafana
```

---

## UML Diagrams

The following diagrams are provided in PlantUML format to allow easy rendering and modification by contributors.

---

### Component Diagram

<img width="387" height="564" alt="image" src="https://github.com/user-attachments/assets/c97bd902-0f90-493d-844f-e1a4a45adefe" />

---

### OTP Supervision Tree

<img width="566" height="321" alt="image" src="https://github.com/user-attachments/assets/31ac8de4-2ef8-4b98-9afa-c552f1b988e5" />


---

### Request and Metrics Flow

<img width="435" height="326" alt="image" src="https://github.com/user-attachments/assets/3744c0f1-f263-4c2c-a2d8-ab3a4eb41d98" />


---

### Deployment Diagram


<img width="222" height="336" alt="image" src="https://github.com/user-attachments/assets/bf33e9ff-c0c3-46c6-97b7-9072afeea4ec" />


---

## Project Structure

```text
elixir_monitoring_server/
├── lib/
│   ├── server/
│   │   ├── application.ex    # Supervision tree
│   │   ├── router.ex         # HTTP routing
│   │   ├── metrics.ex        # Telemetry metrics
│   │   ├── metrics_exporter.ex # Prometheus exporter
│   │   └── worker.ex         # Supervised background worker
│   └── server.ex
├── config/
├── priv/
├── test/
└── mix.exs
```

---

## Getting Started

### Requirements

* Elixir 1.15 or newer
* Erlang/OTP 26 or newer
* Prometheus
* Grafana

---

### Setup

```bash
mix deps.get
mix compile
```

---

### Running the Server

```bash
mix run --no-halt
```

Default address:

```
http://localhost:4000
```

---

## Available Endpoints

| Endpoint   | Purpose              |
| ---------- | -------------------- |
| `/`        | Root endpoint        |
| `/health`  | Service health check |
| `/metrics` | Prometheus metrics   |
| `/worker/status` | Worker liveness|

---

## Prometheus Configuration

```yaml
scrape_configs:
  - job_name: "elixir_monitoring_server"
    static_configs:
      - targets: ["localhost:4000"]
```

---

## Grafana Usage

* Add Prometheus as a data source
* Build dashboards using metrics such as request rate, latency, and error counts

<img width="1360" height="610" alt="Screenshot at 2025-12-27 01-05-56" src="https://github.com/user-attachments/assets/9b404611-7d68-40dd-a797-ea1326e98703" />



Example query:

```promql
rate(http_request_count[1m])
```

---

## Reliability and Design Principles

* OTP supervisors automatically restart failed processes
* Isolation between HTTP handling and background workers
* Metrics collection is non-blocking
* Designed for long-running services

---

## Open Source and Contributions

This project is intended to be **fully open source**.

Contributions are welcome in the form of:

* Additional metrics
* Improved dashboards
* Documentation enhancements
* Distributed monitoring support
* Alerting and automation

---

## License

MIT License

---

## Maintainer

DarynOngera

---

This project emphasizes **clarity, correctness, and real-world backend practices** rather than framework-specific abstractions.

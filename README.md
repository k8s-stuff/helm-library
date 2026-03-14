# helm-library

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/helm-library)](https://artifacthub.io/packages/search?repo=helm-library)
[![Release](https://github.com/k8s-stuff/helm-library/actions/workflows/release.yaml/badge.svg)](https://github.com/k8s-stuff/helm-library/actions/workflows/release.yaml)
[![Lint](https://github.com/k8s-stuff/helm-library/actions/workflows/lint.yaml/badge.svg)](https://github.com/k8s-stuff/helm-library/actions/workflows/lint.yaml)

A Helm **library chart** that provides reusable, opinionated templates for
deploying applications on Kubernetes. Instead of copying boilerplate across
charts, depend on this library and get a production-ready Deployment, Service,
Ingress, HPA, TLS, secrets management, external-secrets integration, and
Prometheus monitoring out of the box — driven entirely by `values.yaml`.

<!-- TODO: Add any project-specific context about why this library exists and
     what conventions/opinions it encodes for your organisation. -->

## Requirements

| Requirement | Version |
|-------------|---------|
| Helm        | `>= 3.x` |
| Kubernetes  | `>= 1.19` |

## Installation

### OCI Registry (recommended)

```bash
helm pull oci://ghcr.io/k8s-stuff/helm-library --version 1.0.0
```

Or reference it directly as a dependency in your `Chart.yaml`:

```yaml
dependencies:
  - name: helm-library
    version: "1.0.0"
    repository: "oci://ghcr.io/k8s-stuff"
```

### Classic Helm Repository

```bash
helm repo add k8s-stuff https://k8s-stuff.github.io/helm-library
helm repo update
```

Then in your `Chart.yaml`:

```yaml
dependencies:
  - name: helm-library
    version: "1.0.0"
    repository: "https://k8s-stuff.github.io/helm-library"
```

## Usage

### 1. Add the library as a dependency

In your application chart's `Chart.yaml`:

```yaml
apiVersion: v2
name: my-app
type: application
version: 0.1.0

dependencies:
  - name: helm-library
    version: ">=1.0.0"
    repository: "oci://ghcr.io/k8s-stuff"
```

Run `helm dependency update` to fetch it.

### 2. Include the global template

Create a single template file (e.g. `templates/deployment.yaml`) in your
application chart:

```yaml
{{- include "helm-lib.deployment.global" . }}
```

This one line renders all the resources the library manages — Deployment,
Service, Secrets, Ingress, HPA, ServiceMonitor, and more — based on your
`values.yaml`.

### 3. Configure via values

```yaml
image:
  repository: my-org/my-app
  tag: "2.0.0"

service:
  port: 80
  targetPort: 8080

ingress:
  enabled: true
  className: nginx
  hosts:
    - host: my-app.example.com
      paths:
        - path: /
          pathType: Prefix

autoscaling:
  enabled: true
  minReplicas: 2
  maxReplicas: 10
  targetCPUUtilizationPercentage: 75

appSettings:
  database_url: "postgres://..."
```

## Available Templates

The library exposes these named templates:

### Top-level Orchestrator

| Template | Description |
|----------|-------------|
| `helm-lib.deployment.global` | Renders all resources below in a single include |

### Resource Templates

| Template | Description |
|----------|-------------|
| `helm-lib.deployment.deploy` | Deployment with probes, init containers, volumes, security contexts |
| `helm-lib.deployment.service` | Service (ClusterIP/NodePort/LoadBalancer) with additional ports |
| `helm-lib.deployment.ingress` | Ingress with multi-version API support (v1, v1beta1) |
| `helm-lib.deployment.hpa` | HorizontalPodAutoscaler (autoscaling/v2) for CPU/memory |
| `helm-lib.deployment.serviceAccount` | ServiceAccount with annotations and automount control |
| `helm-lib.deployment.servicemonitor` | Prometheus ServiceMonitor (requires Prometheus Operator) |
| `helm-lib.deployment.secret-app-settings` | Secret for application config (JSON, mounted as file) |
| `helm-lib.deployment.secret-env` | Secret for environment variables (from `extraSecretEnv`) |
| `helm-lib.deployment.secret-tls` | kubernetes.io/tls Secret for TLS cert/key |
| `helm-lib.deployment.secret-authorities` | Secret for trusted CA certificates |
| `helm-lib.deployment.secret-scripts` | Secret containing the CA bundle combine script |
| `helm-lib.deployment.secretstore` | External Secrets Operator SecretStore |
| `helm-lib.deployment.externalsecret` | External Secrets Operator ExternalSecret |

### Helper Templates

| Template | Description |
|----------|-------------|
| `helm-lib.name` | Chart name (truncated to 63 chars) |
| `helm-lib.fullname` | Fully qualified app name |
| `helm-lib.chart` | Chart name + version string |
| `helm-lib.labels` | Standard Kubernetes labels |
| `helm-lib.selectorLabels` | Selector labels for Deployments/Services |
| `helm-lib.serviceAccountName` | Resolved service account name |
| `helm-lib.values.service.type` | Service type with default `ClusterIP` |
| `helm-lib.values.service.port` | Service port with default `80` |
| `helm-lib.values.service.targetPort` | Target port with default `8080` |
| `helm-lib.values.service.targetScheme` | Target scheme with default `HTTP` |
| `helm-lib.values.application.configPath` | App config mount path (default `/app`) |
| `helm-lib.values.configFileName` | Config file name (default `<name>.settings.json`) |
| `helm-lib.values.affinity` | Default pod anti-affinity (spread across nodes) |
| `helm-lib.is-flag-enabled-default-true` | Boolean flag helper (defaults to `true`) |
| `helm-lib.is-flag-enabled-default-false` | Boolean flag helper (defaults to `false`) |

## Key Features

- **Single-line deployment**: `{{ include "helm-lib.deployment.global" . }}` renders everything
- **Health checks**: Startup, liveness, and readiness probes with sensible defaults
- **TLS support**: Mount TLS certs with optional CA bundle init container
- **External Secrets**: Native SecretStore and ExternalSecret support
- **Prometheus monitoring**: ServiceMonitor with customizable endpoints
- **Auto-scaling**: HPA with CPU and memory targets
- **Config checksums**: Automatic rollout on config/secret changes
- **Pod anti-affinity**: Spread pods across nodes by default
- **Multi-version Ingress**: Supports Kubernetes 1.14+ Ingress APIs

## Examples

See the [`examples/`](examples/) directory for a working application chart that
depends on this library.

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for
guidelines on how to develop, test, and submit changes.

## License

This project is licensed under the Apache License 2.0 — see the [LICENSE](LICENSE)
file for details.

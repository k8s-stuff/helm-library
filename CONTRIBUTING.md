# Contributing to helm-library

Thank you for your interest in contributing! This guide covers everything you
need to get started.

## Prerequisites

- [Helm](https://helm.sh/docs/intro/install/) >= 3.x
- [chart-testing (`ct`)](https://github.com/helm/chart-testing#installation)
  (optional, for running the full lint suite locally)
- [helm-docs](https://github.com/norwoodj/helm-docs) (optional, for
  regenerating documentation)

## Development Setup

```bash
git clone https://github.com/k8s-stuff/helm-library.git
cd helm-library
```

## Running Linting Locally

Library charts cannot be linted directly because they produce no manifests.
Instead, lint through the example chart that depends on the library:

```bash
# Update dependencies (pulls the local library chart)
helm dependency update examples/example-app

# Lint the example chart
helm lint examples/example-app
```

To run the full chart-testing suite (same as CI):

```bash
ct lint --chart-dirs charts --all
```

## Running the Example Chart

You can template the example chart to verify rendered output without a cluster:

```bash
helm dependency update examples/example-app
helm template my-release examples/example-app
```

To install on a real cluster (e.g. a local kind/minikube):

```bash
helm dependency update examples/example-app
helm install my-release examples/example-app
```

## Making Changes

1. **Fork** the repository and create a feature branch from `main`.
2. Make your changes in `charts/helm-library/templates/` or `values.yaml`.
3. Update or add entries in `charts/helm-library/values.yaml` for any new
   configuration knobs.
4. Run linting locally (see above) to catch issues early.
5. If you add a new template or helper, document it in the root `README.md`
   tables.
6. Update the example chart if needed to exercise your changes.

## Cutting a Release

Releases are fully automated via GitHub Actions. To publish a new version:

1. Update the `version` field in `charts/helm-library/Chart.yaml` following
   [semver](https://semver.org/).
2. Commit and push to `main`.
3. Create and push a Git tag matching the version:

   ```bash
   git tag v1.2.0
   git push origin v1.2.0
   ```

4. The release workflow will automatically:
   - Package and push the chart to GHCR (`oci://ghcr.io/k8s-stuff/helm-library`)
   - Create a GitHub Release with the `.tgz` artifact
   - Update the `gh-pages` branch `index.yaml` for classic Helm repo users

## Pull Request Guidelines

- Keep PRs focused — one feature or fix per PR.
- Write a clear description of **what** and **why**.
- Ensure linting passes (`helm lint` on the example chart).
- Add or update documentation for any user-facing changes.
- Follow existing code style and naming conventions in the templates.
- If your change is breaking, note it clearly in the PR description and bump the
  major version in `Chart.yaml`.

## Reporting Issues

Please open a [GitHub Issue](https://github.com/k8s-stuff/helm-library/issues)
with:
- A clear description of the problem or feature request
- Steps to reproduce (if it's a bug)
- Expected vs actual behaviour
- Helm and Kubernetes versions you're using

## Code of Conduct

Be respectful and constructive. We follow the
[Contributor Covenant](https://www.contributor-covenant.org/version/2/1/code_of_conduct/).

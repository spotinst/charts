# Spot Helm Chart Repository for Kubernetes [![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/spot)](https://artifacthub.io/packages/search?repo=spot)

The official repository for all Spot Helm Charts for Kubernetes.

## Table of Contents

- [Installation](#installation)
- [Documentation](#documentation)
- [Getting Help](#getting-help)
- [Community](#community)
- [Contributing](#contributing)
- [License](#license)

## Installation

1. Add the chart repository:

```sh
helm repo add spot https://charts.spot.io
```

2. Update information of available charts:

```sh
helm repo update
```

3. Install a chart. For example, install the Ocean Controller:

```sh
helm install ocean-controller spot/ocean-controller \
  --set spotinst.token=REDACTED \
  --set spotinst.account=REDACTED \
  --set spotinst.clusterIdentifier=REDACTED
```

> NOTE: Please configure all required chart values using the `set` command line argument or a `values.yaml` file.

## Documentation

If you're new to Spot and want to get started, please checkout our [Getting Started](https://docs.spot.io/connect-your-cloud-provider/) guide, available on the [Spot Documentation](https://docs.spot.io/) website.

## Getting Help

We use GitHub issues for tracking bugs and feature requests. Please use these community resources for getting help:

- Ask a question on [Stack Overflow](https://stackoverflow.com/) and tag it with [spot-charts](https://stackoverflow.com/questions/tagged/spot-charts/).
- Join our Spot community on [Slack](http://slack.spot.io/).
- Open an [issue](https://github.com/spotinst/charts/issues/new/choose/).

## Community

- [Slack](http://slack.spot.io/)
- [Twitter](https://twitter.com/spotinst/)

## Contributing

Please see the [contribution guidelines](.github/CONTRIBUTING.md).

## License

Code is licensed under the [Apache License 2.0](https://github.com/spotinst/charts/blob/master/LICENSE/).

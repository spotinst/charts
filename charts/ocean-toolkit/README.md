## Ocean Toolkit

Helm chart to deploy the Ocean Toolkit.

## Requirements

| Repository                    | Name           | Version |
| ----------------------------- | -------------- | ------- |
| https://charts.spot.io        | controller     | 1.1.\*  |
| https://charts.spot.io        | operator       | 0.1.\*  |
| https://charts.helm.sh/stable | metrics-server | 2.11.\* |

## Values

| Key                          | Description                                                | Type     | Default | Required |
| ---------------------------- | ---------------------------------------------------------- | -------- | ------- | -------- |
| global.spot.account          | Specifies the Spot account ID                              | `string` | `none`  | `yes`    |
| global.spot.token            | Specifies the Spot Personal Access Token                   | `string` | `none`  | `yes`    |
| global.rbac.create           | Specifies whether RBAC resources should be created         | `bool`   | `true`  | `no`     |
| global.rbac.pspEnabled       | Specifies whether a PodSecurityPolicy should be created    | `bool`   | `true`  | `no`     |
| global.imagePullSecrets      | Specifies a list of secrets to be used when pulling images | `list`   | `[]`    | `no`     |
| controller.enabled           | Specifies whether Ocean Controller should be deployed      | `bool`   | `true`  | `no`     |
| controller.clusterIdentifier | Specifies the Ocean Controller ID                          | `bool`   | `none`  | `yes`    |
| operator.enabled             | Specifies whether Ocean Operator should be deployed        | `bool`   | `true`  | `no`     |
| metrics-server.enabled       | Specifies whether Metrics Server should be deployed        | `bool`   | `true`  | `no`     |

## Installation

1. Add the chart repository:

```sh
$ helm repo add spot https://charts.spot.io
```

2. Update information of available charts:

```sh
$ helm repo update
```

3. Install the Ocean Toolkit:

```sh
$ helm install ocean-toolkit spot/ocean-toolkit \
  --set global.spot.token=REDACTED \
  --set global.spot.account=REDACTED \
  --set controller.clusterIdentifier=REDACTED
```

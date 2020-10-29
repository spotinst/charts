## Wave Toolkit

This chart will deploy the Wave Toolkit.

## Requirements

| Repository                       | Name                 | Version |
| -------------------------------- | -------------------- | ------- |
| https://charts.spot.io           | ocean-toolkit        | 0.1.\*  |
| https://charts.helm.sh/stable    | efs-provisioner      | 0.13.\* |
| https://charts.helm.sh/stable    | spark-history-server | 1.3.\*  |
| https://charts.helm.sh/incubator | sparkoperator        | 0.8.\*  |

## Values

| Key                                        | Description                                                | Type     | Default | Required |
| ------------------------------------------ | ---------------------------------------------------------- | -------- | ------- | -------- |
| global.spot.account                        | Spot account ID                                            | `string` | `none`  | `yes`    |
| global.spot.token                          | Spot Personal Access Token                                 | `string` | `none`  | `yes`    |
| global.rbac.create                         | Specifies whether RBAC resources should be created         | `bool`   | `true`  | `no`     |
| global.rbac.pspEnabled                     | Specifies whether a PodSecurityPolicy should be created    | `bool`   | `true`  | `no`     |
| global.imagePullSecrets                    | Specifies a list of secrets to be used when pulling images | `list`   | `[]`    | `no`     |
| ocean-toolkit.enabled                      | Specifies whether Ocean Toolkit should be deployed         | `bool`   | `true`  | `no`     |
| ocean-toolkit.controller.clusterIdentifier | Specifies the Ocean Controller ID                          | `bool`   | `none`  | `yes`    |
| efs-provisioner.enabled                    | Specifies whether EFS Provisioner should be deployed       | `bool`   | `true`  | `no`     |
| spark-history-server.enabled               | Specifies whether Spark History Server should be deployed  | `bool`   | `true`  | `no`     |
| sparkoperator.enabled                      | Specifies whether Spark Operator should be deployed        | `bool`   | `true`  | `no`     |

## Installation

1. Add the chart repository:

```sh
$ helm repo add spot https://charts.spot.io
```

2. Update information of available charts:

```sh
$ helm repo update
```

3. Install the Wave Toolkit:

```sh
$ helm install ocean-toolkit spot/wave-toolkit \
  --set global.spot.token=REDACTED \
  --set global.spot.account=REDACTED
```

# ocean-network-client

![Version: 1.1.0](https://img.shields.io/badge/Version-1.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.8](https://img.shields.io/badge/AppVersion-1.0.8-informational?style=flat-square)

A Helm chart for Ocean Network Client.

## Installation

1. Add the Spot Helm chart repository:

```sh
helm repo add spot https://charts.spot.io
```

2. Update your local Helm chart repository cache:

```sh
helm repo update
```

3a. Install `ocean-network-client` and generate secret and configMap:
```sh
helm install my-release spot/ocean-network-client \
  --set spotinst.account=$SPOTINST_ACCOUNT \
  --set spotinst.clusterIdentifier=$SPOTINST_CLUSTER_IDENTIFIER \
  --set spotinst.token=$SPOTINST_TOKEN \
  --namespace spot-system --set namespace=spot-system
```

3b. Install `ocean-network-client` with your own secret or configMap:
```sh
helm install my-release spot/ocean-network-client \
  --set secretName=$SECRET_NAME \
  --set configMapName=$CONFIG_MAP_NAME \
  --namespace spot-system --set namespace=spot-system
```

> NOTE: Please configure all required chart values using the `set` command line argument or a `values.yaml` file.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| configMapName | Optional | `""` | ConfigMap name to use. In case spotinst.clusterIdentifier is provided, this overrides the name of the created configMap. |
| image.pullPolicy | Optional | `"IfNotPresent"` | Image pull policy. |
| image.pullSecrets | Optional | `[]` | Image pull secrets. |
| image.repository | Optional | `"public.ecr.aws/spotinst/spot-network-client"` | Image repository. |
| image.tag | Optional | `""` | Image tag. Defaults to `.Chart.AppVersion`. |
| namespace | Optional | `"kube-system"` | Namespace where components should be installed. |
| oceanController | object | `{"configMapName":"","secretName":""}` | Reference secret and configMap for the Ocean Controller. Deprecated in favor of spotinst object or secretName and configMapName |
| oceanController.configMapName | Optional | `""` | ConfigMap name. Deprecated use configMapName instead |
| oceanController.secretName | Optional | `""` | Secret name. Deprecated use secretName instead. |
| resources | Optional | `{"requests":{"cpu":"30m","memory":"150Mi"}}` | Resource requests and limits. Ref: http://kubernetes.io/docs/user-guide/compute-resources/ |
| secretName | Optional | `""` | Secret name to use. In case spotinst.token, spotinst.account are provided, this overrides the name of the created secret. |
| spotinst.account | Optional | `""` | Spot Account. Ref: https://docs.spot.io/administration/organizations?id=account |
| spotinst.clusterIdentifier | Optional | `""` | Unique identifier used by the Ocean Controller to connect between the Ocean backend and the Kubernetes cluster. Ref: https://docs.spot.io/ocean/tutorials/spot-kubernetes-controller/ |
| spotinst.token | Optional | `""` | Spot Token. Ref: https://docs.spot.io/administration/api/create-api-token |
| tolerations | Optional | `[{"operator":"Exists"}]` | Tolerations - Enable pods to run an all nodes in cluster Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/ |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.13.1](https://github.com/norwoodj/helm-docs/releases/v1.13.1)

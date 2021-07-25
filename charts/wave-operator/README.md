# wave-operator

![Version: 0.2.5](https://img.shields.io/badge/Version-0.2.5-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.3.0](https://img.shields.io/badge/AppVersion-0.3.0-informational?style=flat-square)

A Helm chart for Wave Operator. This chart is usually invoked by the [spotctl](https://github.com/spotinst/spotctl) tool, but may also be run manually.

## Prerequisites

| Repository                 | Name           | Version    | Notes                                                                                                                                                                                                                                               |
| -------------------------- | -------------- | ---------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| https://charts.jetstack.io | `cert-manager` | `>= 1.0.4` | [Cert Manager](https://cert-manager.io/) must be installed before the Wave Operator, as several components depend on certificate request. It is not necessary to use the `cert-manager` Helm chart, if some other installation method is preferred. |

## Installation

1. Add the Spot Helm chart repository:

```sh
helm repo add spot https://charts.spot.io
```

2. Update your local Helm chart repository cache:

```sh
helm repo update
```

3. Install `wave-operator`:

```sh
helm install my-release spot/wave-operator [...]
```

> NOTE: Please configure all required chart values using the `set` command line argument or a `values.yaml` file.

## Values

| Key                        | Type   | Default                                                                                                                                                                       | Description                                                                                                                                          |
| -------------------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| affinity.nodeAffinity      | object | `{"preferredDuringSchedulingIgnoredDuringExecution":[{"preference":{"matchExpressions":[{"key":"spotinst.io/node-lifecycle","operator":"In","values":["od"]}]},"weight":1}]}` | Node affinity.                                                                                                                                       |
| fullnameOverride           | string | `""`                                                                                                                                                                          |                                                                                                                                                      |
| image.pullPolicy           | string | `"IfNotPresent"`                                                                                                                                                              | Image pull policy.                                                                                                                                   |
| image.repository           | string | `"public.ecr.aws/l8m2k1n1/netapp/wave-operator"`                                                                                                                              | Image repository.                                                                                                                                    |
| image.tag                  | string | `nil`                                                                                                                                                                         | Overrides the image tag whose default is latest.                                                                                                     |
| imagePullSecrets           | list   | `[]`                                                                                                                                                                          | Image pull secrets.                                                                                                                                  |
| nameOverride               | string | `""`                                                                                                                                                                          |                                                                                                                                                      |
| nodeSelector               | object | `{}`                                                                                                                                                                          | Node selector.                                                                                                                                       |
| podAnnotations             | object | `{}`                                                                                                                                                                          | Pod annotations. Ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/                                                 |
| podSecurityContext         | object | `{}`                                                                                                                                                                          | Pod security context. Ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod             |
| replicaCount               | int    | `1`                                                                                                                                                                           | Replicas. Ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas                                                        |
| resources                  | object | `{"limits":{"cpu":"500m","memory":"500Mi"},"requests":{"cpu":"50m","memory":"50Mi"}}`                                                                                         | Resource requests and limits. Ref: http://kubernetes.io/docs/user-guide/compute-resources/                                                           |
| securityContext            | object | `{}`                                                                                                                                                                          | Container security context. Ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container |
| serviceAccount.annotations | object | `{}`                                                                                                                                                                          | Service account annotations.                                                                                                                         |
| serviceAccount.create      | bool   | `true`                                                                                                                                                                        | Controls whether a service account should be created.                                                                                                |
| serviceAccount.name        | string | `"wave-operator"`                                                                                                                                                             | Service account name.                                                                                                                                |
| tolerations                | list   | `[]`                                                                                                                                                                          | Tolerations for nodes that have taints on them. Ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/                         |

---

Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)

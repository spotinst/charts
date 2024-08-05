# ocean-vpa

![Version: 1.0.1](https://img.shields.io/badge/Version-1.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Helm chart for Kubernetes.

## Installation

1. Add the Spot Helm chart repository:

```sh
helm repo add spot https://charts.spot.io
```

2. Update your local Helm chart repository cache:

```sh
helm repo update
```

3. Install `ocean-vpa`:

```sh
helm install my-release spot/ocean-vpa
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| admissionController.affinity | object | `{}` |  |
| admissionController.certGen.affinity | object | `{}` |  |
| admissionController.certGen.env | object | `{}` | Additional environment variables to be added to the certgen container. Format is KEY: Value format |
| admissionController.certGen.image.pullPolicy | string | `"Always"` | The pull policy for the certgen image. Recommend not changing this |
| admissionController.certGen.image.repository | string | `"registry.k8s.io/ingress-nginx/kube-webhook-certgen"` | An image that contains certgen for creating certificates. Only used if admissionController.generateCertificate is true |
| admissionController.certGen.image.tag | string | `"v1.4.1"` | An image tag for the admissionController.certGen.image.repository image. Only used if admissionController.generateCertificate is true |
| admissionController.certGen.nodeSelector | object | `{}` |  |
| admissionController.certGen.resources | object | `{}` | The resources block for the certgen pod |
| admissionController.certGen.securityContext | object | `{}` | The securityContext block for the certgen pod |
| admissionController.certGen.tolerations | list | `[]` |  |
| admissionController.generateCertificate | bool | `true` | If true and admissionController is enabled, a pre-install hook will run to create the certificate for the webhook |
| admissionController.httpPort | int | `8000` | Port of the admission controller for the mutating webhooks |
| admissionController.image.pullPolicy | string | `"Always"` | The pull policy for the admission controller image. Recommend not changing this |
| admissionController.image.repository | string | `"registry.k8s.io/autoscaling/vpa-admission-controller"` | The location of the vpa admission controller image |
| admissionController.image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion |
| admissionController.mutatingWebhookConfiguration.annotations | object | `{}` | Additional annotations for the MutatingWebhookConfiguration. Can be used for integration with cert-manager |
| admissionController.nodeSelector | object | `{}` |  |
| admissionController.podAnnotations | object | `{}` | Annotations to add to the admission controller pod |
| admissionController.podLabels | object | `{}` | Labels to add to the admission controller pod |
| admissionController.podSecurityContext | object | `{"runAsNonRoot":true,"runAsUser":65534,"seccompProfile":{"type":"RuntimeDefault"}}` | The security context for the admission controller pod |
| admissionController.replicaCount | int | `1` |  |
| admissionController.resources | object | `{"limits":{},"requests":{"cpu":"50m","memory":"200Mi"}}` | The resources block for the admission controller pod |
| admissionController.secretName | string | `"{{ include \"ocean-vpa.fullname\" . }}-tls-secret"` | Name for the TLS secret created for the webhook. Default {{ .Release.Name }}-tls-secret |
| admissionController.tlsSecretKeys | list | `[]` | The keys in the vpa-tls-certs secret to map in to the admission controller |
| admissionController.tolerations | list | `[]` |  |
| fullnameOverride | string | `""` | A template override for the fullname |
| imagePullSecrets | list | `[]` | A list of image pull secrets to be used for all pods |
| nameOverride | string | `""` | A template override for the name |
| priorityClassName | string | `""` | To set the priorityclass for all pods |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service accounts for each component |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created for each component |
| serviceAccount.name | string | `""` | The base name of the service account to use (appended with the component). If not set and create is true, a name is generated using the fullname template and appended for each component |
| updater.affinity | object | `{}` |  |
| updater.evictionTolerance | float | `0.25` |  |
| updater.extraArgs.min-replicas | int | `1` |  |
| updater.image.pullPolicy | string | `"Always"` | The pull policy for the updater image. Recommend not changing this |
| updater.image.repository | string | `"registry.k8s.io/autoscaling/vpa-updater"` | The location of the updater image |
| updater.image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion |
| updater.nodeSelector | object | `{}` |  |
| updater.podAnnotations | object | `{}` | Annotations to add to the updater pod |
| updater.podLabels | object | `{}` | Labels to add to the updater pod |
| updater.podSecurityContext | object | `{"runAsNonRoot":true,"runAsUser":65534,"seccompProfile":{"type":"RuntimeDefault"}}` | The security context for the updater pod |
| updater.replicaCount | int | `1` |  |
| updater.resources | object | `{"limits":{},"requests":{"cpu":"50m","memory":"500Mi"}}` | The resources block for the updater pod |
| updater.tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.13.1](https://github.com/norwoodj/helm-docs/releases/v1.13.1)
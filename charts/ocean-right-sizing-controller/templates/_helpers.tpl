{{/*
Expand the name of the chart.
*/}}
{{- define "ocean-right-sizing-controller.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ocean-right-sizing-controller.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified app name for the auto-updater job.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "auto-updater.fullname" -}}
{{- if .Values.autoUpdate.fullnameOverride }}
{{- .Values.autoUpdate.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "auto-updater" .Values.autoUpdate.nameOverride }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ocean-right-sizing-controller.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
The image to use
*/}}
{{- define "ocean-right-sizing-controller.image" -}}
{{- $imageSuffix := "" }}
{{- if and .Values.image.fips .Values.image.tag }}
{{- fail "`image.fips` should not be used together with `image.tag`. Either set `--image.fips=false` or `--image.tag=\"\"`" }}
{{- end }}
{{- if .Values.image.fips }}
{{- $imageSuffix = "-fips" }}
{{- end }}
{{- printf "%s:%s%s" .Values.image.repository (default (printf "v%s" .Chart.AppVersion) .Values.image.tag) $imageSuffix }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ocean-right-sizing-controller.labels" -}}
helm.sh/chart: {{ include "ocean-right-sizing-controller.chart" . }}
{{ include "ocean-right-sizing-controller.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ocean-right-sizing-controller.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ocean-right-sizing-controller.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels Auto Updater
*/}}
{{- define "auto-updater.labels" -}}
helm.sh/chart: {{ include "ocean-right-sizing-controller.chart" . }}
{{ include "auto-updater.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels Auto Updater
*/}}
{{- define "auto-updater.selectorLabels" -}}
app.kubernetes.io/name: auto-updater
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
ConfigMap name.
*/}}
{{- define "ocean-right-sizing-controller.configMapName" -}}
{{ default (include "ocean-right-sizing-controller.fullname" .) .Values.configMap.name }}
{{- end }}

{{/*
Secret name.
*/}}
{{- define "ocean-right-sizing-controller.secretName" -}}
{{ default (include "ocean-right-sizing-controller.fullname" .) .Values.secret.name }}
{{- end }}

{{/*
CA bundle secret name.
*/}}
{{- define "ocean-right-sizing-controller.caBundleSecretName" -}}
{{ default (printf "%s-ca-bundle" (include "ocean-right-sizing-controller.fullname" .)) .Values.caBundleSecret.name }}
{{- end }}

{{/*
ClusterRole name.
*/}}
{{- define "ocean-right-sizing-controller.clusterRoleName" -}}
{{ include "ocean-right-sizing-controller.fullname" . }}
{{- end }}

{{/*
ClusterRoleBinding name.
*/}}
{{- define "ocean-right-sizing-controller.clusterRoleBindingName" -}}
{{ include "ocean-right-sizing-controller.fullname" . }}
{{- end }}

{{/*
Create the name of the service-account to use
*/}}
{{- define "ocean-right-sizing-controller.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ocean-right-sizing-controller.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service-account to use for the auto-updater
*/}}
{{- define "auto-updater.serviceAccountName" -}}
{{- if .Values.autoUpdate.serviceAccount.create }}
{{- default (include "auto-updater.fullname" .) .Values.autoUpdate.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.autoUpdate.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Controller default affinity
*/}}
{{- define "ocean-right-sizing-controller.defaultAffinity" -}}
nodeAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    nodeSelectorTerms:
    - matchExpressions:
      - key: kubernetes.io/os
        operator: NotIn
        values:
        - windows
  preferredDuringSchedulingIgnoredDuringExecution:
  - weight: 100
    preference:
      matchExpressions:
      - key: node-role.kubernetes.io/control-plane
        operator: Exists
{{- end }}

{{/*
Controller default tolerations
*/}}
{{- define "ocean-right-sizing-controller.defaultTolerations" -}}
- key: node.kubernetes.io/not-ready
  effect: NoExecute
  operator: Exists
  tolerationSeconds: 150
- key: node.kubernetes.io/unreachable
  effect: NoExecute
  operator: Exists
  tolerationSeconds: 150
- key: node-role.kubernetes.io/master
  operator: Exists
- key: node-role.kubernetes.io/control-plane
  operator: Exists
- key: CriticalAddonsOnly
  operator: Exists
{{- end }}

{{/*
Controller affinity
*/}}
{{- define "ocean-right-sizing-controller.affinity" -}}
{{- if kindIs "invalid" .Values.affinity -}}
{{- include "ocean-right-sizing-controller.defaultAffinity" . -}}
{{- else }}
{{- .Values.affinity | toYaml -}}
{{- end }}
{{- end }}

{{/*
Controller topology spread constraints
*/}}
{{- define "ocean-right-sizing-controller.topologySpreadConstraints" -}}
{{- if kindIs "invalid" .Values.topologySpreadConstraints -}}
- maxSkew: 1
  topologyKey: kubernetes.io/hostname
  whenUnsatisfiable: DoNotSchedule
  labelSelector:
    matchLabels:
      {{- include "ocean-right-sizing-controller.selectorLabels" . | nindent 6 }}
{{- else }}
{{- .Values.topologySpreadConstraints | toYaml -}}
{{- end }}
{{- end }}

{{/*
Auto-Updater affinity
*/}}
{{- define "auto-updater.affinity" -}}
{{- if kindIs "invalid" .Values.autoUpdate.affinity -}}
{{- include "ocean-right-sizing-controller.defaultAffinity" . -}}
{{- else }}
{{- .Values.autoUpdate.affinity | toYaml -}}
{{- end }}
{{- end }}

{{/*
Auto-Updater tolerations
*/}}
{{- define "auto-updater.tolerations" -}}
{{- if kindIs "invalid" .Values.autoUpdate.tolerations -}}
- key: node.kubernetes.io/not-ready
  effect: NoExecute
  operator: Exists
  tolerationSeconds: 150
- key: node.kubernetes.io/unreachable
  effect: NoExecute
  operator: Exists
  tolerationSeconds: 150
- key: node-role.kubernetes.io/master
  operator: Exists
- key: node-role.kubernetes.io/control-plane
  operator: Exists
- key: CriticalAddonsOnly
  operator: Exists
{{- else }}
{{- .Values.autoUpdate.tolerations | toYaml -}}
{{- end }}
{{- end }}

{{/*
NO_PROXY environment variable
*/}}
{{- define "ocean-right-sizing-controller.noProxyEnvVar" -}}
{{- $hasNoProxyEnvVar := false -}}
{{- range .Values.extraEnv }}
{{- if eq .name "NO_PROXY" }}
{{- $hasNoProxyEnvVar = true }}
{{- end }}
{{- end }}
{{- if and .Values.spotinst.proxyUrl (not $hasNoProxyEnvVar) -}}
- name: NO_PROXY
  value: '$(KUBERNETES_SERVICE_HOST)' # will be replaced to $(KUBERNETES_SERVICE_HOST) in cluster
{{ end -}}
{{- end }}

{{/*
Metrics-server serviceaccount name
*/}}
{{- define "metrics-server.serviceAccountName" -}}
{{- $name := "metrics-server" }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Metrics-server fullname
*/}}
{{- define "metrics-server.fullname" -}}
{{- $name := "metrics-server" }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Metrics-server name
*/}}
{{- define "metrics-server.name" -}}
metrics-server
{{- end }}

{{/*
Figure out if we should deploy metrics server. We are checking:
- if 'metrics-server.deployChart' is true:
  - try to fetch the 'v1beta1.metrics.k8s.io' APIService
  - if it exists:
    - check for it's helm annotations to see if it was installed as part of the
      same release we are installing now (release name and namespace annotations).
    - if it's not the same release -> fail
*/}}
{{- define "ocean-right-sizing-controller.deployMetricsServer" }}
{{- if (index .Values "metrics-server" "deployChart") }}
{{- $apiService := lookup "apiregistration.k8s.io/v1" "APIService" "" "v1beta1.metrics.k8s.io" }}
{{- $releaseName := .Release.Name }}
{{- $releaseNamespace := .Release.Namespace }}
{{- if $apiService -}}
{{- with $apiService }}
{{- if (or
    (not .metadata.annotations)
    (or
        (ne
            $releaseName
            (index .metadata.annotations "meta.helm.sh/release-name")
        )
        (ne
            $releaseNamespace
            (index .metadata.annotations "meta.helm.sh/release-namespace")
        )
    ))
}}
{{- fail "\nThe value: 'metrics-server.deployChart' was set to 'true' but we found another installation of metrics-server in your cluster.\nYou must use:\n    --set metrics-server.deployChart=false" }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Log Shipping - Should Enable

Should only enabled log shipping if controller is installed against prod SaaS environment
or if another log shipping destination host is specified.
*/}}
{{- define "ocean-right-sizing-controller.logShipping.enabled" -}}
{{- if and .Values.logShipping .Values.logShipping.enabled -}}
{{- if (or
    (or (eq .Values.spotinst.baseUrl "") (eq .Values.spotinst.baseUrl "api.spotinst.io:443"))
    (ne .Values.logShipping.destination.host "api.spotinst.io")
) -}}
true
{{- end }}
{{- end }}
{{- end }}

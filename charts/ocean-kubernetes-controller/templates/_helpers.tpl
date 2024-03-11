{{/*
Expand the name of the chart.
*/}}
{{- define "ocean-kubernetes-controller.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ocean-kubernetes-controller.fullname" -}}
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
{{- define "ocean-kubernetes-controller.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
The image to use
*/}}
{{- define "ocean-kubernetes-controller.image" -}}
{{- printf "%s:%s" .Values.image.repository (default (printf "v%s" .Chart.AppVersion) .Values.image.tag) }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ocean-kubernetes-controller.labels" -}}
helm.sh/chart: {{ include "ocean-kubernetes-controller.chart" . }}
{{ include "ocean-kubernetes-controller.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ocean-kubernetes-controller.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ocean-kubernetes-controller.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
ConfigMap name.
*/}}
{{- define "ocean-kubernetes-controller.configMapName" -}}
{{ default (include "ocean-kubernetes-controller.fullname" .) .Values.configMap.name }}
{{- end }}

{{/*
Secret name.
*/}}
{{- define "ocean-kubernetes-controller.secretName" -}}
{{ default (include "ocean-kubernetes-controller.fullname" .) .Values.secret.name }}
{{- end }}

{{/*
CA bundle secret name.
*/}}
{{- define "ocean-kubernetes-controller.caBundleSecretName" -}}
{{ default (printf "%s-ca-bundle" (include "ocean-kubernetes-controller.fullname" .)) .Values.caBundleSecret.name }}
{{- end }}

{{/*
ClusterRole name.
*/}}
{{- define "ocean-kubernetes-controller.clusterRoleName" -}}
{{ include "ocean-kubernetes-controller.fullname" . }}
{{- end }}

{{/*
ClusterRoleBinding name.
*/}}
{{- define "ocean-kubernetes-controller.clusterRoleBindingName" -}}
{{ include "ocean-kubernetes-controller.fullname" . }}
{{- end }}

{{/*
Create the name of the service-account to use
*/}}
{{- define "ocean-kubernetes-controller.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ocean-kubernetes-controller.fullname" .) .Values.serviceAccount.name }}
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
NO_PROXY environment variable
*/}}
{{- define "ocean-kubernetes-controller.noProxyEnvVar" -}}
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
Figure out if we should deploy metrics server. We are checking:
- if 'metrics-server.deployChart' is true:
  - try to fetch the 'v1beta1.metrics.k8s.io' APIService
  - if it exists:
    - check for it's helm annotations to see if it was installed as part of the
      same release we are installing now (release name and namespace annotations).
    - if it's not the same release -> fail
*/}}
{{- define "ocean-kubernetes-controller.deployMetricsServer" }}
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
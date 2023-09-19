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
{{ default (include "ocean-kubernetes-controller.name" .) .Values.configMap.name }}
{{- end }}

{{/*
Secret name.
*/}}
{{- define "ocean-kubernetes-controller.secretName" -}}
{{ default (include "ocean-kubernetes-controller.name" .) .Values.secret.name }}
{{- end }}

{{/*
CA bundle secret name.
*/}}
{{- define "ocean-kubernetes-controller.caBundleSecretName" -}}
{{ default (include "ocean-kubernetes-controller.name" .) .Values.caBundleSecret.name }}
{{- end }}

{{/*
ClusterRole name.
*/}}
{{- define "ocean-kubernetes-controller.clusterRoleName" -}}
{{ include "ocean-kubernetes-controller.name" . }}
{{- end }}

{{/*
ClusterRoleBinding name.
*/}}
{{- define "ocean-kubernetes-controller.clusterRoleBindingName" -}}
{{ include "ocean-kubernetes-controller.name" . }}
{{- end }}

{{/*
Deployment name.
*/}}
{{- define "ocean-kubernetes-controller.deploymentName" -}}
{{ include "ocean-kubernetes-controller.name" . }}
{{- end }}

{{/*
Job name (ocean-aks-connector).
*/}}
{{- define "ocean-kubernetes-controller.aksConnectorJobName" -}}
{{ default (include "ocean-kubernetes-controller.name" .) .Values.aksConnector.jobName }}
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "ocean-kubernetes-controller.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ocean-kubernetes-controller.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

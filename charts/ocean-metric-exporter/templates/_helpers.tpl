{{/* vim: set filetype=mustache: */}}

{{/*
{{/*
Expand the name of the chart.
*/}}
{{- define "ocean-metric-exporter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to
this (by the DNS naming spec). If release name contains chart name it will be
used as a full name.
*/}}
{{- define "ocean-metric-exporter.fullname" -}}
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
{{- define "ocean-metric-exporter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Namespace.
*/}}
{{- define "ocean-metric-exporter.namespace" -}}
{{- if .Values.oceanController.namespace -}}
{{ .Values.oceanController.namespace }}
{{- else -}}
{{ .Release.Namespace }}
{{- end }}
{{- end }}

{{/*
Create Secret.
*/}}
{{- define "ocean-metric-exporter.createSecret" -}}
{{- if or .Values.spotinst.token .Values.spotinst.account -}}
{{- true -}}
{{- end -}}
{{- end -}}

{{/*
Create ConfigMap.
*/}}
{{- define "ocean-metric-exporter.createConfigMap" -}}
{{- if .Values.spotinst.clusterIdentifier -}}
{{- true -}}
{{- end -}}
{{- end -}}

{{/*
Common labels.
*/}}
{{- define "ocean-metric-exporter.labels" -}}
helm.sh/chart: {{ include "ocean-metric-exporter.chart" . }}
{{ include "ocean-metric-exporter.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels.
*/}}
{{- define "ocean-metric-exporter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ocean-metric-exporter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Secret name.
*/}}
{{- define "ocean-metric-exporter.secretName" -}}
{{ default (include "ocean-metric-exporter.name" .) .Values.oceanController.secretName }}
{{- end }}

{{/*
ConfigMap name.
*/}}
{{- define "ocean-metric-exporter.configMapName" -}}
{{ default (include "ocean-metric-exporter.name" .) .Values.oceanController.configMapName }}
{{- end }}

{{/*
CA bundle secret name.
*/}}
{{- define "ocean-metric-exporter.caBundleSecretName" -}}
{{ default (include "ocean-metric-exporter.name" .) .Values.oceanController.caBundleSecretName }}
{{- end }}

{{/*
Deployment Name.
*/}}
{{- define "ocean-metric-exporter.deploymentName" -}}
{{- printf "spot-%s" (include "ocean-metric-exporter.name" .) -}}
{{- end }}

{{/*
Service Name.
*/}}
{{- define "ocean-metric-exporter.serviceName" -}}
{{- printf "spot-%s" (include "ocean-metric-exporter.name" .) -}}
{{- end }}

{{/*
Container command.
*/}}
{{- define "ocean-metric-exporter.command" -}}
{{- printf "[ \"java\", \"-Dspring.profiles.active=prod,default\", \"-jar\", \"/app/app.jar\" ]" -}}
{{- end }}

{{/*
probes.
*/}}
{{- define "ocean-metric-exporter.probes" -}}
{{- if or .Values.probes.liveness.enabled .Values.probes.enabled }}
livenessProbe:
  httpGet:
    path: /health/liveness
    port: exporter
  initialDelaySeconds: {{ .Values.probes.liveness.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.liveness.periodSeconds }}
  failureThreshold: {{ .Values.probes.liveness.failureThreshold }}
  timeoutSeconds: {{ .Values.probes.liveness.timeoutSeconds }}
{{- end}}
{{- if or .Values.probes.readiness.enabled .Values.probes.enabled }}
readinessProbe:
  httpGet:
    path: /health/readiness
    port: exporter
  initialDelaySeconds: {{ .Values.probes.readiness.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.readiness.periodSeconds }}
  failureThreshold: {{ .Values.probes.readiness.failureThreshold }}
  successThreshold: {{ .Values.probes.readiness.successThreshold }}
  timeoutSeconds: {{ .Values.probes.readiness.timeoutSeconds }}
{{- end}}
{{- end }}
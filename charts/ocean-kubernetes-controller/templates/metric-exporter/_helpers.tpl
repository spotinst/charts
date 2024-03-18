{{/*
Expand the name of the chart.
*/}}
{{- define "ocean-metric-exporter.name" -}}
{{- $values := (index .Values "ocean-metric-exporter") -}}
{{- default "ocean-metric-exporter" $values.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ocean-metric-exporter.fullname" -}}
{{- $values := (index .Values "ocean-metric-exporter") -}}
{{- if $values.fullnameOverride }}
{{- $values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (include "ocean-metric-exporter.name" .) $values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ocean-metric-exporter.labels" -}}
helm.sh/chart: {{ include "ocean-kubernetes-controller.chart" . }}
{{ include "ocean-metric-exporter.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ocean-metric-exporter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ocean-metric-exporter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
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
{{- $values := index .Values "ocean-metric-exporter" }}
{{- if or $values.probes.liveness.enabled $values.probes.enabled }}
livenessProbe:
  httpGet:
    path: /health/liveness
    port: exporter
  initialDelaySeconds: {{ $values.probes.liveness.initialDelaySeconds }}
  periodSeconds: {{ $values.probes.liveness.periodSeconds }}
  failureThreshold: {{ $values.probes.liveness.failureThreshold }}
  timeoutSeconds: {{ $values.probes.liveness.timeoutSeconds }}
{{- end}}
{{- if or $values.probes.readiness.enabled $values.probes.enabled }}
readinessProbe:
  httpGet:
    path: /health/readiness
    port: exporter
  initialDelaySeconds: {{ $values.probes.readiness.initialDelaySeconds }}
  periodSeconds: {{ $values.probes.readiness.periodSeconds }}
  failureThreshold: {{ $values.probes.readiness.failureThreshold }}
  successThreshold: {{ $values.probes.readiness.successThreshold }}
  timeoutSeconds: {{ $values.probes.readiness.timeoutSeconds }}
{{- end}}
{{- end }}
{{/* vim: set filetype=mustache: */}}

{{/* Chart name. */}}
{{- define "provisioner.name" -}}
{{- default .Chart.Name .Values.nameOverride }}
{{- end -}}

{{/* Fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this
(by the DNS naming spec). If release name contains chart name it will be used as
a full name. */}}
{{- define "provisioner.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/* Chart name and version as used by the chart label. */}}
{{- define "provisioner.chartref" -}}
{{- replace "+" "_" .Chart.Version | printf "%s-%s" .Chart.Name -}}
{{- end -}}

{{/* Generate basic labels. */}}
{{- define "provisioner.labels" }}
chart: {{ template "provisioner.chartref" . }}
release: {{ $.Release.Name | quote }}
heritage: {{ $.Release.Service | quote }}
{{- if .Values.labels -}}
{{ toYaml .Values.labels }}
{{- end -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "ocean-network-client.name" -}}
{{- default .Chart.Name .Values.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Namespace.
*/}}
{{- define "ocean-network-client.namespace" -}}
{{ default (include "ocean-network-client.name" .) .Values.oceanController.namespace }}
{{- end }}

{{/*
ConfigMap name.
*/}}
{{- define "ocean-network-client.configMapName" -}}
{{ default (include "ocean-network-client.name" .) .Values.oceanController.configMapName }}
{{- end }}

{{/*
Secret name.
*/}}
{{- define "ocean-network-client.secretName" -}}
{{ default (include "ocean-network-client.name" .) .Values.oceanController.secretName }}
{{- end }}

{{/*
DaemonSet labels.
*/}}
{{- define "ocean-network-client.daemon-set.labels" -}}
app: ocean-network-client
{{- end }}

{{/*
NodeSelector labels.
*/}}
{{- define "ocean-network-client.node-selector.labels" -}}
kubernetes.io/os: linux
{{- end }}
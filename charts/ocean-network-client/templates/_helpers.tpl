{{/*
Expand the name of the chart.
*/}}
{{- define "ocean-network-client.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Namespace.
*/}}
{{- define "ocean-network-client.namespace" -}}
{{ default (include "ocean-network-client.name" .) .Values.namespace }}
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
{{- define "ocean-network-client.ds.labels" -}}
app: netflowd
{{- end }}

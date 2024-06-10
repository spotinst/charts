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
{{ default (include "ocean-network-client.name" .) .Values.namespace }}
{{- end }}

{{/*
ConfigMap name.
*/}}
{{- define "ocean-network-client.configMapName" -}}
{{- if ne .Values.spotinst.clusterIdentifier "" -}}
{{- .Values.oceanInfoData  -}}
{{- else -}}
{{- default (include "ocean-network-client.name" .) .Values.configMapName -}}
{{- end -}}
{{- end -}}

{{/*
Secret name.
*/}}
{{- define "ocean-network-client.secretName" -}}
{{- if ne .Values.spotinst.account "" -}}
{{- .Values.oceanInfoData  -}}
{{- else -}}
{{ default (include "ocean-network-client.name" .) .Values.oceanController.secretName }}
{{- end -}}
{{- end -}}

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
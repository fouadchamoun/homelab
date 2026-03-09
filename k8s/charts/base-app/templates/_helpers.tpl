{{/*
Expand the name of the chart.
*/}}
{{- define "base-app.name" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "base-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "base-app.labels" -}}
helm.sh/chart: {{ include "base-app.chart" . }}
{{ include "base-app.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "base-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "base-app.name" . }}
app.kubernetes.io/instance: {{ include "base-app.name" . }}
{{- end }}

{{/*
Create host match rule as used by the ingress route.
*/}}
{{- define "base-app.ingressRouteMatchRule" -}}
{{- if .Values.ingressRoute.matchRule -}}
{{- .Values.ingressRoute.matchRule | quote -}}
{{- else -}}
{{- printf "Host(`%s.homelab.fouad.dev`)" (include "base-app.name" .) }}
{{- end }}
{{- end }}

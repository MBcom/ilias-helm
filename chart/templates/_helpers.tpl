{{/*
Expand the name of the release.
*/}}
{{- define "ilias.name" -}}
{{-   default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "ilias.labels" -}}
app.kubernetes.io/name: {{ include "ilias.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{-   if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{-   end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "ilias.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ilias.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
DB Host generator
*/}}
{{- define "ilias.dbHost" -}}
{{-   if .Values.ilias.db.host }}
{{- .Values.ilias.db.host -}}
{{-   else -}}
{{- .Release.Name }}-mariadb
{{-   end -}}
{{- end -}}
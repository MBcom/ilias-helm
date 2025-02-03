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
{{- .Values.ilias.db.host }}
{{-   else if .Values.mariadbGalera.enabled }}
{{- .Release.Name }}-mariadb-galera
{{-   else }}
{{- .Release.Name }}-mariadb
{{-   end -}}
{{- end -}}


{{/*
DB Username generator
*/}}
{{- define "ilias.dbUser" -}}
{{-   if .Values.ilias.db.user }}
{{- .Values.ilias.db.user }}
{{-   else if .Values.mariadbGalera.enabled }}
{{- .Values.mariadbGalera.db.user }}
{{-   else }}
{{- .Values.mariadb.auth.username }}
{{-   end -}}
{{- end -}}


{{/*
DB Password generator
*/}}
{{- define "ilias.dbPassword" -}}
{{-   if .Values.ilias.db.password }}
{{- .Values.ilias.db.user }}
{{-   else if .Values.mariadbGalera.enabled }}
{{- .Values.mariadbGalera.db.password }}
{{-   else }}
{{- .Values.mariadb.auth.password }}
{{-   end -}}
{{- end -}}


{{/*
DB Name generator
*/}}
{{- define "ilias.dbName" -}}
{{-   if .Values.ilias.db.name }}
{{- .Values.ilias.db.user }}
{{-   else if .Values.mariadbGalera.enabled }}
{{- .Values.mariadbGalera.db.name }}
{{-   else }}
{{- .Values.mariadb.auth.database }}
{{-   end -}}
{{- end -}}



{{/*
Render templates from values.yaml .
Code from https://github.com/bitnami/charts/blob/e77870b5c15230186ce3091f2b620b7de986999f/bitnami/common/templates/_tplvalues.tpl
Copyright Broadcom, Inc. All Rights Reserved.
SPDX-License-Identifier: APACHE-2.0
*/}}
{{- define "common.tplvalues.render" -}}
{{- $value := typeIs "string" .value | ternary .value (.value | toYaml) }}
{{- if contains "{{" (toJson .value) }}
  {{- if .scope }}
      {{- tpl (cat "{{- with $.RelativeScope -}}" $value "{{- end }}") (merge (dict "RelativeScope" .scope) .context) }}
  {{- else }}
    {{- tpl $value .context }}
  {{- end }}
{{- else }}
    {{- $value }}
{{- end }}
{{- end -}}